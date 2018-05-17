//
//  UITextFieldExtensions.swift
//  Podfy
//
//  Created by Luiz Hammerli on 17/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

extension UITextField{
    
    func setUpTextFieldAttributes(placeholderText: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
    }
    
}
