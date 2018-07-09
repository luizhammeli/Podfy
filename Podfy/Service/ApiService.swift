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
import SystemConfiguration
import Foundation

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
    
    //Reference: https://stackoverflow.com/questions/35563654/checking-for-network-connection-with-reachability-iswwan-flag-always-false
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability =  withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
