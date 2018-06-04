//
//  MainTabBarViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import AVFoundation

class MainTabBarViewController: UITabBarController {

    var mainPlayerView: MainPlayer!
    var topAnchor: NSLayoutConstraint!
    static var shared: MainTabBarViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(minimizePlayer), name: NSNotification.Name.minimizePlayerControllerNotificationName, object: nil)
        MainTabBarViewController.shared = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpViews(){
        mainPlayerView = Bundle.main.loadNibNamed(Strings.mainPlayer, owner: self, options: nil)?.first as! MainPlayer
        mainPlayerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(mainPlayerView, belowSubview: tabBar)
        
        topAnchor = mainPlayerView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height)
        topAnchor?.isActive = true
        mainPlayerView?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        mainPlayerView?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        mainPlayerView?.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
    }
    
    func showMainPlayerView(_ episode: Episode){
        self.mainPlayerView.episode = episode
        maximizePlayer()
    }
    
    func maximizePlayer(){
        topAnchor?.constant = 0
        self.mainPlayerView.miniPlayer.alpha = 0
        self.mainPlayerView.mainStackView.alpha = 1
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)

            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func minimizePlayer(){
        self.mainPlayerView.miniPlayer.alpha = 1
        self.mainPlayerView.mainStackView.alpha = 0
        topAnchor?.constant = self.view.frame.height-(64+self.tabBar.frame.height)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.tabBar.transform = .identity
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
