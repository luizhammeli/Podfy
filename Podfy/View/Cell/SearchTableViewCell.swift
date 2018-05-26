//
//  SearchTableViewCell.swift
//  Podfy
//
//  Created by iOS Developer on 22/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    var podcast: Podcast?{
        didSet{
            guard let podcast = podcast, let artworkUrl = podcast.artworkUrl600, let count = podcast.trackCount else {return}
            guard let url = URL(string: artworkUrl) else {return}
            episodeTitleLabel.text = podcast.trackName
            artistLabel.text = podcast.artistName
            podcastImage.sd_setImage(with: url, completed: nil)
            let episodesText = count > 1 ? "espisodes" : "episode"
            numberOfEpisodesLabel.text = "\(count) \(episodesText)"
            
        }
    }
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var numberOfEpisodesLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
