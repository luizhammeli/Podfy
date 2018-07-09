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
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                handler(error, nil)
                return
            }
            guard let user = result?.user else {return}
            
            self.saveUserInDatabase(user: user, name: name, handler: handler)
        }
    }
    
    func defaultLogin(_ email: String, password: String, handler: @escaping (AuthDataResult?, Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func facebookLogin(handler: @escaping (AuthDataResult?, Error?)->Void){
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let visibleViewController = rootViewController.visibleViewController else{return}
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: visibleViewController) { (result, error) in
            if let error = error{
                print("Error")
                handler(nil, error)
                return
            }
            if let accessToken = FBSDKAccessToken.current(){
                guard let accessTokenString = accessToken.tokenString else { return }
                let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)                
                Auth.auth().signInAndRetrieveData(with: credentials, completion: handler)
            }else{
                handler(nil, NSError(domain: "", code: 0, userInfo: nil))
            }
        }
    }
    
    func resetPassword(_ email: String, handler: @escaping (Error?)->Void){
        Auth.auth().sendPasswordReset(withEmail: email, completion: handler)
    }
    
    func saveUserInDatabase(user: User, name: String, handler: @escaping (Error?, DatabaseReference?)->Void){
         Database.database().reference().child("user").child(user.uid).updateChildValues(["email" : user.email ?? "", "name": name], withCompletionBlock: handler)
    }
    
    func saveFavoriteInDatabase(podcast: Podcast, handler: @escaping (Error?, DatabaseReference?)->Void){
        guard let id = Auth.auth().currentUser?.uid else {return}
        guard let trackName = podcast.trackName else {return}
        let value = ["trackName" : trackName, "artistName": podcast.artistName ?? "", "feedUrl": podcast.feedUrl ?? "", "podcast": podcast.artworkUrl600 ?? ""]
        Database.database().reference().child("favorite").child(id).child(trackName).updateChildValues(value, withCompletionBlock: handler)
    }
    
    func removeFavoriteInDatabase(podcast: Podcast, handler: @escaping (Error?, DatabaseReference?)->Void){         
        guard let id = Auth.auth().currentUser?.uid else {return}
        guard let trackName = podcast.trackName else {return}
        Database.database().reference().child("favorite").child(id).child(trackName).removeValue(completionBlock: handler)
    }
    
    func checkFavorite(podcast: Podcast,  handler: @escaping (_ isFavorite: Bool?)->Void){
        guard let id = Auth.auth().currentUser?.uid else {return}
        guard let trackName = podcast.trackName else {return}
        Database.database().reference().child("favorite").child(id).child(trackName).observeSingleEvent(of: .value, with: { (snapshot) in            
            guard let dict = snapshot.value as? [String: Any] else {return}
            if(!dict.isEmpty){
                handler(true)
            }
            handler(false)
            
        }) { (error) in
            handler(false)
        }
    }
    
    func fetchFavorites(handler: @escaping (_ podcasts: [Podcast], _ errorMessage: String?)->Void){
        guard let id = Auth.auth().currentUser?.uid else {return}
        var podcasts = [Podcast]()        
        if (!ApiService.shared.isConnectedToNetwork()){
            handler(podcasts, "Network Error")
            return
        }
        Database.database().reference().child("favorite").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {handler(podcasts, nil); return}
            dictionaries.forEach({(key: String, value: Any) in
                guard let podcastDict = value as? [String: Any] else {handler(podcasts, nil); return}
                podcasts.append(Podcast(podcastDict))
            })
            handler(podcasts, nil)
        }) { (error) in
            handler(podcasts, nil)
        }
    }
}
