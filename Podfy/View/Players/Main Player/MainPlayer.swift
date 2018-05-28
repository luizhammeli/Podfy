//
//  MainPlayer.swift
//  Podfy
//
//  Created by iOS Developer on 23/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import Foundation

class MainPlayer: UIView{
    
    var miniPlayer: MiniPlayer!
    @IBOutlet var podcastImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    var episode:Episode?{
        didSet{
            miniPlayer.alpha = 0
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            guard let url = URL(string: episode.imageUrl) else {return}
            podcastImageView.sd_setImage(with: url, completed: nil)
            miniPlayer.episode = episode
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        miniPlayer.containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressMiniPlayerContainerView)))
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
    
    @objc func didPressMiniPlayerContainerView(){
        miniPlayer.alpha = 0
        MainTabBarViewController.shared?.maximizePlayer()
    }
    
    @IBAction func didPressMinimizeButton(_ sender: Any) {
        NotificationCenter.default.post(name: .minimizePlayerControllerNotificationName, object: nil)
    }
    
    @IBAction func didPressPlayButton(_ sender: Any) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.podcastImageView.transform = self.scale
            self.playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }, completion: nil)
          }
}
