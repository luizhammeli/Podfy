//
//  UIButtonExtensions.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit


extension UIButton{
    
    func setUpSignUpAttributesText(){
        let attributedString = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.foregroundColor :  UIColor.customGrayColor])
        attributedString.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.foregroundColor : UIColor.customGreenColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.5, weight: UIFont.Weight.bold)]))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
