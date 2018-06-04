//
//  LoginViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 16/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setUpContainerView()
        emailTextField.setUpTextFieldAttributes(placeholderText: Strings.emailPlaceHolderLabel)
        passwordTextField.setUpTextFieldAttributes(placeholderText: Strings.passwordPlaceHolderLabel)
        signUpButton.setUpSignUpAttributesText()             
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        if (Auth.auth().currentUser != nil){
            self.performSegue(withIdentifier: Strings.goToMainTabController, sender: self)
        }else{
            navigationController?.isNavigationBarHidden = false
            containerView.removeFromSuperview()
        }
    }
    
    func setUpContainerView(){
        self.view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        appDelegate?.customActivityIndicator.showActivityIndicator()
        FirebaseApiService.shared.defaultLogin(email, password: password) { (user, error) in
            self.appDelegate?.customActivityIndicator.hideActivityIndicator()
            if let error = error{
                CustomAlertController.showCustomAlert(Strings.loginErrorMessage, message: error.localizedDescription.description, delegate: self)
                return
            }            
            self.performSegue(withIdentifier: Strings.goToMainTabController, sender: self)
        }
    }
    
    @IBAction func didPressFacebookButton(_ sender: Any) {
        appDelegate?.customActivityIndicator.showActivityIndicator()
        FirebaseApiService.shared.facebookLogin { (user, error) in
            self.appDelegate?.customActivityIndicator.hideActivityIndicator()
            if error != nil {
                return
            }
            self.performSegue(withIdentifier: Strings.goToMainTabController, sender: self)
        }
    }
}
