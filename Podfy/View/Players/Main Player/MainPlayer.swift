//
//  MainPlayer.swift
//  Podfy
//
//  Created by iOS Developer on 23/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import AVFoundation

class MainPlayer: UIView{
    
    var miniPlayer: MiniPlayer!
    @IBOutlet var podcastImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var podcastDurationLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    
    let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var episode:Episode?{
        didSet{
            miniPlayer.alpha = 0
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            guard let url = URL(string: episode.imageUrl) else {return}
            podcastImageView.sd_setImage(with: url, completed: nil)
            miniPlayer.episode = episode
            playEpisode()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        miniPlayer.containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressMiniPlayerContainerView)))
        setUpAudioSession()
        addPeriodicTimeObserver()
        addTimeObserver()
        addNotification()
        //addFeedNotification()
        //addGesturesRecognizer()

        //setUpRemoteControl()
    }
    

    func setUpViews(){
        miniPlayer = Bundle.main.loadNibNamed("MiniPlayer", owner: self, options: nil)?.first as! MiniPlayer
        miniPlayer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(miniPlayer)
        miniPlayer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        miniPlayer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        miniPlayer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        miniPlayer.heightAnchor.constraint(equalToConstant: 64).isActive = true
        miniPlayer.alpha = 0
    }
        
    func playAudio(_ url: URL){
        playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        let avItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: avItem)
        player.play()
    }
    
    func enlargeEpisodeImageView(enlarge: Bool){
        
        let scale = enlarge ? .identity : self.scale
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.podcastImageView.transform = scale
        }, completion: nil)
    }
    
    @objc func didPressMiniPlayerContainerView(){
        miniPlayer.alpha = 0
        mainStackView.alpha = 1
        MainTabBarViewController.shared?.maximizePlayer()
    }
    
    @IBAction func didPressMinimizeButton(_ sender: Any) {
        miniPlayer.alpha = 1
        mainStackView.alpha = 0
        NotificationCenter.default.post(name: .minimizePlayerControllerNotificationName, object: nil)
    }
    
    @IBAction func didPressPlayButton(_ sender: Any) {
        if (player.timeControlStatus == .paused){
            enlargeEpisodeImageView(enlarge: true)
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlayer.setPlayButtonImage(#imageLiteral(resourceName: "pause"))
            player.play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            enlargeEpisodeImageView(enlarge: false)
            miniPlayer.setPlayButtonImage(#imageLiteral(resourceName: "play"))
            player.pause()
        }
    }
    
    @IBAction func handleFastButton(_ sender: Any) {
        fastRewindPodcast(time: 15)
    }
    
    @IBAction func handleRewindButton(_ sender: Any) {
        fastRewindPodcast(time: -15)
    }
    
    @IBAction func CurrentTimeSliderValueChanged(_ sender: UISlider) {
        changeCurrentTime(sender.value)
    }
}
