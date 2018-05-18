//
//  CustomActivityIndicator.swift
//  Podfy
//
//  Created by Luiz Hammerli on 18/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class CustomActivityIndicator: UIView {
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showActivityIndicator(){
        setUpView()
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator(){
        backgroundView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
    func setUpView(){
        guard let visibleViewController = rootViewController?.visibleViewController else {return}
        visibleViewController.view.addSubview(backgroundView)
        backgroundView.addSubview(activityIndicator)
        
        backgroundView.topAnchor.constraint(equalTo: visibleViewController.view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: visibleViewController.view.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: visibleViewController.view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: visibleViewController.view.rightAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
    }
}
