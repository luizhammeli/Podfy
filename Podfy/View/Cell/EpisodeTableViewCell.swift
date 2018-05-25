//
//  EpisodeTableViewCell.swift
//  Podfy
//
//  Created by iOS Developer on 24/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            episodeLabel.text = episode.title
            episodeLabel.numberOfLines = 2
            descriptionLabel.numberOfLines = 2
            descriptionLabel.text = episode.description
            guard let url = URL(string: episode.imageUrl.checkHttpsString()) else {return}
            dateLabel.text = episode.pubDate.getPodcastDateType()
            episodeImageView.sd_setImage(with: url, completed: nil)
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
