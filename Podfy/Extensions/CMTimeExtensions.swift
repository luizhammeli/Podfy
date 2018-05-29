//
//  CMTimeExtensions.swift
//  Podfy
//
//  Created by iOS Developer on 29/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import AVFoundation

extension CMTime{
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let hours = totalSeconds / 60 / 60
        return String(format: "%02d:%02d:%02d" , hours, minutes, seconds)
    }
}

