//
//  APIService.swift
//  Podfy
//
//  Created by iOS Developer on 22/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import Alamofire
import FeedKit

class ApiService {
    
    static let shared = ApiService()
    let baseURL = "https://itunes.apple.com/search"
    
    func fetchPodcasts(_ searchText: String, completionHandler: @escaping ([Podcast]?, Error?)->Void){
        
        let parameters = ["entity":"podcast", "term": searchText]
        
        Alamofire.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataReponse) in
            
            if let error = dataReponse.error{
                print(error)
                completionHandler(nil, error)
                return
            }
            
            guard let data = dataReponse.data else {return}
            let results = self.convertJson(data)
            completionHandler(results, nil)
        }
    }
    
    func fetchEpisodes(podcast: Podcast?, completionHandler: @escaping (([Episode])->Void)){
        guard let stringUrl = podcast?.feedUrl else {return}
        guard let url = URL(string: stringUrl) else {return}
        var episodes = [Episode]()
        
        DispatchQueue.global(qos: .background).async {
            let parser = FeedParser(URL: url)
            parser?.parseAsync(result: { (result) in
                
                if let error = result.error{
                    print("error to parse episodes feed: \(error)")
                    return
                }
                
                if let rss = result.rssFeed{
                    episodes = rss.getFeedEpisodes()
                }
                
                completionHandler(episodes)
            })
        }
    }
    
    func convertJson(_ data: Data)->[Podcast]{
        do{
            let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
            return searchResult.results
        }catch let error{
            print(error)
        }
        return [Podcast]()
    }
}
