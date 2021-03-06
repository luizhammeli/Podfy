//
//  SearchViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 20/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchResultTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    var podcasts = [Podcast]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        self.searchResultTableView.tableFooterView = UIView()
        
    }
    
    //MARK:- SearchBar
    fileprivate func setUpSearchController(){
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.tintColor = .white
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
        self.definesPresentationContext = true
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchResultTableView.dequeueReusableCell(withIdentifier: Strings.cellID, for: indexPath) as! SearchTableViewCell
        cell.podcast = podcasts[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (podcasts.count == 0){ return 80 }else{ return 0 }
    }        
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.appDelegate.customActivityIndicator.showActivityIndicator()
            ApiService.shared.fetchPodcasts(searchText) { (results, error) in
                self.appDelegate.customActivityIndicator.hideActivityIndicator()
                if let error = error{
                    CustomAlertController.showCustomAlert("Search Error", message: error.localizedDescription.description, delegate: self)
                    return
                }                
                if let results = results{
                    self.podcasts = results
                    self.searchResultTableView.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CustomSearchLabel()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Strings.goToEpisodes, sender: podcasts[indexPath.item])
        self.searchResultTableView.deselectRow(at: indexPath, animated: true)        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchController.searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != Strings.goToEpisodes){return}        
        guard let episodesController = segue.destination as? EpisodesViewController else {return}
        guard let podcast = sender as? Podcast else {return}
        episodesController.podcast = podcast
    }
}
