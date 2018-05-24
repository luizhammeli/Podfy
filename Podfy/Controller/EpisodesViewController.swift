//
//  EpisodesViewController.swift
//  Podfy
//
//  Created by iOS Developer on 24/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var likeBarButton: UIBarButtonItem!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let cellID = "cellID"
    var podcast: Podcast?
    var episodes = [Episode]()
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        fetchEpisodes()
    }
    
    func setUpViews(){
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = podcast?.trackName        
    }
    
    func fetchEpisodes(){
        appDelegate.customActivityIndicator.showActivityIndicator()
        ApiService.shared.fetchEpisodes(podcast: podcast) { (episodes) in
            DispatchQueue.main.async {
                self.appDelegate.customActivityIndicator.hideActivityIndicator()
                self.episodes = episodes
                self.tableView.reloadData()
            }            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EpisodeTableViewCell
        cell.episode = episodes[indexPath.item]
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func didPressLikeButton(_ sender: Any) {
        guard let podcast = podcast else {return}
        appDelegate.customActivityIndicator.showActivityIndicator()
        if (isFavorite){
            FirebaseApiService.shared.removeFavoriteInDatabase(podcast: podcast) { (error, _) in
                self.appDelegate.customActivityIndicator.hideActivityIndicator()
                self.removeFavorite(error)
            }
            return
        }
        FirebaseApiService.shared.saveFavoriteInDatabase(podcast: podcast) { (error, reference) in
            self.appDelegate.customActivityIndicator.hideActivityIndicator()
            self.addFavorite(error)
        }
    }
    
    func removeFavorite(_ error: Error?){
        if let error = error{
            CustomAlertController.showCustomAlert("Erro", message: error.localizedDescription.description, delegate: self)
            return
        }
        self.likeBarButton.image = #imageLiteral(resourceName: "like")
        self.isFavorite = false
        CustomAlertController.showCustomAlert("Favoritos", message: "Conteúdo removido com sucesso", delegate: self)
    }
    
    func addFavorite(_ error: Error?){
        if let error = error{
            CustomAlertController.showCustomAlert("Erro", message: error.localizedDescription.description, delegate: self)
            return
        }
        self.likeBarButton.image = #imageLiteral(resourceName: "like-filled-50")
        self.isFavorite = true
        CustomAlertController.showCustomAlert("Favoritos", message: "Conteúdo adicionado com sucesso", delegate: self)
    }
}
