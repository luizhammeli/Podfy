//
//  FavoritesCollectionViewCell.swift
//  Podfy
//
//  Created by iOS Developer on 25/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import SDWebImage

class FavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var podcast: Podcast?{
        didSet{
            guard let podcast = podcast else {return}
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else {return}
            favoriteImageView.sd_setImage(with: url, completed: nil)
            artistLabel.text = podcast.artistName
            titleLabel.text = podcast.trackName
        }
    }
}
