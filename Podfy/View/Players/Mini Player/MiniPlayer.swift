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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
