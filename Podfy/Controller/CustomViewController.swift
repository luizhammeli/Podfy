//
//  CustomViewController.swift
//  Podfy
//
//  Created by iOS Developer on 10/07/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import Reachability

class CustomViewController: UIViewController {

    let reachability = Reachability()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            self.appDelegate?.customActivityIndicator.hideActivityIndicator()
            CustomAlertController.showCustomAlert(Strings.networkErrorTitle, message: Strings.networkErrorMessage, delegate: self)
        }
    }

}
