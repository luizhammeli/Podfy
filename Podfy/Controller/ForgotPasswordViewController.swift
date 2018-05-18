//
//  ForgotPasswordViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 18/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    let appDelegalte = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUpTextFieldAttributes(placeholderText: "E-mail")
    }
    
    @IBAction func didPressSendButton(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        appDelegalte?.customActivityIndicator.showActivityIndicator()
        FirebaseApiService.shared.resetPassword(email) { (error) in
            self.appDelegalte?.customActivityIndicator.hideActivityIndicator()
            if let error = error{
                CustomAlertController.showCustomAlert("Reset Password", message: error.localizedDescription.description, delegate: self)
            }
            
            CustomAlertController.showCustomAlert("Reset Password", message: "Please check your e-mail and follow the instructions.", delegate: self)
        }
    }
}
