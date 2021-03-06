//
//  SignUpViewController.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUpTextFieldAttributes(placeholderText: Strings.emailPlaceHolderLabel)
        passwordTextField.setUpTextFieldAttributes(placeholderText: Strings.passwordPlaceHolderLabel)
        nameTextField.setUpTextFieldAttributes(placeholderText: Strings.namePlaceHolderLabel)
    }
    
    @IBAction func didPressSignUp(){
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        if (checkUserData(email, password, name)){
            appDelegate.customActivityIndicator.showActivityIndicator()
            FirebaseApiService.shared.createNewUser(email, password: password, name: name, handler: signUpCompletionHandler)
        }
    }
    
    func checkUserData(_ email: String, _ password: String, _ name: String)-> Bool{        
        if (!email.isEmpty && !password.isEmpty && !name.isEmpty){
            if(password.count < 6 || name.count < 6){
                CustomAlertController.showCustomAlert(Strings.error, message: Strings.emailAndPasswordTextFieldErrorMessage, delegate: self)
                return false
            }
            return true
        }
        CustomAlertController.showCustomAlert(Strings.error, message: Strings.emptyFieldMessage, delegate: self)
        return false
    }
    
    func signUpCompletionHandler(error: Error?, databaseReference:DatabaseReference? ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.customActivityIndicator.hideActivityIndicator()
        
        if let error = error{
            print("Error Create New User: \(error)")
            CustomAlertController.showCustomAlert(Strings.errorMessage, message: error.localizedDescription.description, delegate: self)
        }
        
        let contentStoryboard = UIStoryboard(name: Strings.contentStoryboard, bundle: nil)
        guard let mainTabController = contentStoryboard.instantiateViewController(withIdentifier: Strings.mainTabBarViewController) as? MainTabBarViewController else {return}
        self.present(mainTabController, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
