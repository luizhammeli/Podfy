//
//  CustomAlertController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class CustomAlertController {
    
    static func showCustomAlert(_ title: String, message: String, delegate: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        delegate.present(alertController, animated: true, completion: nil)
    }
}
