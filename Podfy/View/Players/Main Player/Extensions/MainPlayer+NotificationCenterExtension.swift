//
//  MainPlayer+NotificationCenterExtension.swift
//  Podfy
//
//  Created by iOS Developer on 29/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation


extension NSNotification.Name{
    static let playPauseButtonNotificationName = NSNotification.Name(rawValue: "playPauseButton")
    static let fastForwardNotificationName = NSNotification.Name(rawValue: "fastForward")
}

extension MainPlayer{
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didPressPlayButton), name: NSNotification.Name.playPauseButtonNotificationName, object: nil)
    }
}
