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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
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
    
    @IBAction func didPressMinimizeButton(_ sender: Any) {
        NotificationCenter.default.post(name: .minimizePlayerControllerNotificationName, object: nil)
    }
    
    func changeViews(_ episodes: Episode, alpha: Int){
        miniPlayer.alpha = 0
        titleLabel.text = episodes.title
        authorLabel.text = episodes.author
        guard let url = URL(string: episodes.imageUrl) else {return}
        podcastImageView.sd_setImage(with: url, completed: nil)
    }
}
