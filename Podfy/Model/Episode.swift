//
//  Episode.swift
//  Podfy
//
//  Created by iOS Developer on 24/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation
import FeedKit  

struct Episode: Codable{
    
    let title:String
    let pubDate:Date
    let description: String
    var imageUrl: String
    let author:String
    let streamUrl: String
    var fileUrl: String = ""
    
    init(_ feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? feedItem.author ?? ""
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
    }
}
