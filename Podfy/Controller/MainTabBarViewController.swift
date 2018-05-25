//
//  MainTabBarViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var mainPlayerView: MainPlayer!
    var topAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(minimizePlayer), name: NSNotification.Name.minimizePlayerControllerNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showMainPlayerView), name: NSNotification.Name.maximizePlayerControllerNotificationName, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpViews(){
        mainPlayerView = Bundle.main.loadNibNamed("MainPlayer", owner: self, options: nil)?.first as! MainPlayer
        mainPlayerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(mainPlayerView, belowSubview: tabBar)
        
        topAnchor = mainPlayerView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height)
        topAnchor?.isActive = true
        mainPlayerView?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        mainPlayerView?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        mainPlayerView?.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
    }
    
    @objc func showMainPlayerView(){
        topAnchor?.constant = 0
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func minimizePlayer(){
        topAnchor?.constant = self.view.frame.height-(64+self.tabBar.frame.height)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.mainPlayerView.miniPlayer.alpha = 1
            self.tabBar.transform = .identity
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}