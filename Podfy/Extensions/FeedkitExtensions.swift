//
//  FeedkitExtensions.swift
//  Podfy
//
//  Created by iOS Developer on 24/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation
import FeedKit

extension RSSFeed{
    
    func getFeedEpisodes()->[Episode]{
        var episodes = [Episode]()
        self.items?.forEach({ (item) in
            var episode = Episode(item)
            if episode.imageUrl.isEmpty{
                guard let feedImage = self.iTunes?.iTunesImage?.attributes?.href else {return}
                episode.imageUrl = feedImage
            }
            episodes.append(episode)
        })
        
        return episodes
    }
}
