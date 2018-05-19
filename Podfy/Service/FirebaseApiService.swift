//
//  FirebaseApiService.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

class FirebaseApiService {
    
    static let shared = FirebaseApiService()
    let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    
    func createNewUser(_ email: String, password: String, name: String, handler: @escaping (Error?, DatabaseReference?)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                handler(error, nil)
                return
            }
            guard let user = user else {return}
            self.saveUserInDatabase(user: user, name: name, handler: handler)
        }
    }
    
    func defaultLogin(_ email: String, password: String, handler: @escaping (User?, Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func facebookLogin(handler: @escaping (User?, Error?)->Void){
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let visibleViewController = rootViewController.visibleViewController else{return}
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: visibleViewController) { (result, error) in
            if let error = error {
                print("Error")
                CustomAlertController.showCustomAlert("Facebook Login Error", message: error.localizedDescription.description, delegate: visibleViewController)
                return
            }
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else { return }
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signIn(with: credentials, completion: handler)
        }
    }
    
    func resetPassword(_ email: String, handler: @escaping (Error?)->Void){
        Auth.auth().sendPasswordReset(withEmail: email, completion: handler)
    }
    
    func saveUserInDatabase(user: User, name: String, handler: @escaping (Error?, DatabaseReference?)->Void){
         Database.database().reference().child("child").child(user.uid).updateChildValues(["email" : user.email ?? "", "name": name], withCompletionBlock: handler)
    }
    
}
