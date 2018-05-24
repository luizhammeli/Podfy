//
//  DateExtensions.swift
//  Podfy
//
//  Created by iOS Developer on 24/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

extension Date{
    
    func getPodcastDateType()->String{
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "MMMM dd, YYYY"
        return dateFormmater.string(from: self)
    }
}
