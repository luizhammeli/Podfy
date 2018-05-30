//
//  MiniPlayer.swift
//  Podfy
//
//  Created by iOS Developer on 25/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class MiniPlayer: UIView {
    
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var containerView: MiniPlayer!
    
    var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            guard let url = URL(string: episode.imageUrl) else {return}
            episodeImageView.sd_setImage(with: url, completed: nil)
            episodeTitleLabel.text = episode.title
        }
    }
    
    @IBAction func didPressPlayPauseButton(_ sender: Any) {
        if (playButton.imageView?.image == #imageLiteral(resourceName: "pause")){
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }else{
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        NotificationCenter.default.post(name: .playPauseButtonNotificationName, object: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPlayButtonImage(_ image: UIImage){
        playButton.setImage(image, for: .normal)
    }
    
    @IBAction func didPressRewindButton(_ sender: Any) {        
        NotificationCenter.default.post(name: .fastForwardNotificationName, object: self)
    }
}
