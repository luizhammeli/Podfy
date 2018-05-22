//
//  FavoritesViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 18/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import FirebaseAuth

class FavoritesViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    @IBAction func logOut(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "Settings", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .default, handler: { (alert) in
            try? Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
