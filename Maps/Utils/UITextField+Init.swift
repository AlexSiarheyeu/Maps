//
//  UITextField+Init.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String = "Search",
                     backgroundColor: UIColor = .white,
                     cornerRadius: CGFloat = 0,
                     textColor: UIColor = .black,
                     font: UIFont = .systemFont(ofSize: 16),
                     borderColor: UIColor = UIColor.clear,
                     borderWidth: CGFloat = 0) {
        
        self.init()
        
        self.placeholder = placeholder
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        self.setLeftPaddingPoints(8)
        self.setRightPaddingPoints(8)
        
        translatesAutoresizingMaskIntoConstraints = false

    }
}
