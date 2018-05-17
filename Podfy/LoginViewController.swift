//
//  LoginViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 16/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUpTextFieldAttributes(placeholderText: "E-mail")
        passwordTextField.setUpTextFieldAttributes(placeholderText: "Password")
        signUpButton.setUpSignUpAttributesText()
    }
}

