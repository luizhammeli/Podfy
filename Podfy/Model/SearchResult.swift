//
//  SearchResult.swift
//  Podfy
//
//  Created by iOS Developer on 22/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let resultCount: Int
    let results: [Podcast]
}
