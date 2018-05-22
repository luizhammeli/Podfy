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
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(trackName ?? "", forKey: "trackName")
//        aCoder.encode(artistName ?? "", forKey: "artistName")
//        aCoder.encode(artworkUrl600 ?? "", forKey: "artworkUrl600")
//        aCoder.encode(feedUrl ?? "", forKey: "feedUrl")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        trackName = aDecoder.decodeObject(forKey: "trackName") as? String ?? ""
//        artistName = aDecoder.decodeObject(forKey: "artistName") as? String ?? ""
//        artworkUrl600 = aDecoder.decodeObject(forKey: "artworkUrl600") as? String ?? ""
//        feedUrl = aDecoder.decodeObject(forKey: "feedUrl") as? String ?? ""
//    }
    
}
