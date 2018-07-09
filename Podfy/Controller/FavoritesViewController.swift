//
//  FavoritesViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 18/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import FirebaseAuth

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var podcasts = [Podcast]()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        appDelegate?.customActivityIndicator.showActivityIndicator()        
        FirebaseApiService.shared.fetchFavorites { (podcasts) in
            self.appDelegate?.customActivityIndicator.hideActivityIndicator()
            self.podcasts = podcasts
            if(!self.podcasts.isEmpty){
                self.collectionView.reloadData()
            }            
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: Strings.settings, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: Strings.signOut, style: .default, handler: { (alert) in
            try? Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: Strings.cancel, style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: Strings.cellID, for: indexPath) as! FavoritesCollectionViewCell
        cell.podcast = podcasts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width-50)/2
        return CGSize(width: size, height: size+50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Strings.goToEpisodes, sender: podcasts[indexPath.item])
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != Strings.goToEpisodes){return}
        guard let episodesController = segue.destination as? EpisodesViewController else {return}
        guard let podcast = sender as? Podcast else {return}
        episodesController.podcast = podcast
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 64)
    }
}
