//
//  Podcast.swift
//  Podfy
//
//  Created by iOS Developer on 22/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

class Podcast: NSObject,Codable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
    
    convenience init(_ dic: [String: Any]) {
        self.init()
        self.trackName = dic[Strings.trackName] as? String ?? ""
        self.artistName = dic[Strings.artistName] as? String ?? ""
        self.artworkUrl600 = dic[Strings.podcast] as? String ?? ""
        self.feedUrl = dic[Strings.feedUrl] as? String ?? ""
    }
}
