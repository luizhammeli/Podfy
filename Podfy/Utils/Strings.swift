//
//  Strings.swift
//  Podfy
//
//  Created by Luiz Hammerli on 20/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation


class Strings{
    
    //MARK: Messages and Alerts
    static let error = "Error"
    static let cancel = "Cancel"
    static let emptyFieldMessage = "Fields cannot be empty."
    static let emailAndPasswordTextFieldErrorMessage = "Name and Password Fields must have at least six characters"
    static let resetPassword = "Reset Password"
    static let resetPasswordMessage = "Please check your e-mail and follow the instructions."
    static let signUpMessage = "Don't have an account? "
    static let emailPlaceHolderLabel = "E-mail"
    static let passwordPlaceHolderLabel = "Password"
    static let namePlaceHolderLabel = "Name"
    static let okAlertMessage = "Ok"
    static let loginErrorMessage = "Login Error"
    static let errorMessage = "Error"
    static let favorites = "Favorites"
    static let favoriteRemoved = "Favorite Removed"
    static let favoriteAdded = "Favorite Added"
    static let signOut = "Sign Out"
    static let signUp = "Sign Up"
    static let settings = "Settings"
    
    //MARK: JSON Fields
    static let trackName = "trackName"
    static let artistName = "artistName"
    static let podcast = "podcast"
    static let feedUrl = "feedUrl"
    
    //MARK: Segue ID
    static let goToMainTabController = "goToMainTabController"
    static let goToEpisodes = "goToEpisodes" 
    
    //MARK: StoryBoard ID
    static let mainTabBarViewController = "MainTabBarViewController"
    static let mainPlayer = "MainPlayer"
    
    //MARK: Cell ID
    static let cellID = "cellID"
    
    // MARK: NSNotification Name
    static let playPauseButton = "playPauseButton"
    static let fastForward = "fastForward"
    
    static let minimizePlayerController = "minimizePlayerController"
    static let maximizePlayerControllerNotificationName = "maximizePlayerControllerNotificationName"
}
