//
//  CustomLabel.swift
//  Podfy
//
//  Created by iOS Developer on 22/05/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit


class CustomSearchLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "Please enter a search podcast"
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.backgroundColor = .black
        self.textAlignment = .center
    }
}
