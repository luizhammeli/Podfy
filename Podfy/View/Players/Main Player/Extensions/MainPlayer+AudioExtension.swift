//
//  MainPlayer+AudioExtension.swift
//  Podfy
//
//  Created by iOS Developer on 29/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import AVFoundation

extension MainPlayer{
    
    func setUpAudioSession(){
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch let err{
            print(err)
        }
    }
    
    func addPeriodicTimeObserver(){
        let time = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (updateTime)  in
            self?.currentTimeLabel.text = updateTime.toDisplayString()
            self?.updateTimeSlider()
        }
    }
    
    func updateTimeSlider(){
        let currentTime = CMTimeGetSeconds(self.player.currentTime())
        let duration = CMTimeGetSeconds(self.player.currentItem?.duration ?? CMTime(value: 1, timescale: 1))
        let percent = currentTime/duration
        slider.value = Float(percent)
    }
    
    func addTimeObserver(){
        let time = CMTime(value: 1, timescale: 3)
        let timeValue = NSValue(time: time)
        player.addBoundaryTimeObserver(forTimes: [timeValue], queue: .main) {
            [weak self] in
            self?.enlargeEpisodeImageView(enlarge: true)
            self?.podcastDurationLabel.text = self?.player.currentItem?.duration.toDisplayString()
        }
    }
    
    func playEpisode(){
        guard let episode = episode else {return}
        guard let url = URL(string: episode.streamUrl) else {return}
        playAudio(url)
    }
    
    func fastRewindPodcast(time: Int64){
        let seekTime = CMTimeAdd(player.currentTime(), CMTimeMake(time, 1))
        player.seek(to: seekTime)
    }
    
    func changeCurrentTime(_ value: Float){
        guard let duration = player.currentItem?.duration else{return}
        let currentTimeSeconds = CMTimeGetSeconds(duration)
        let percent = Float64(value) * currentTimeSeconds
        player.seek(to: CMTimeMakeWithSeconds(percent, 1))
    }
}
