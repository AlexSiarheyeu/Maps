//
//  UIButton+Init.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/4/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(_: NSObject = NSObject(), title: String, tintColor: UIColor, font: UIFont, backgroundColor: UIColor) {
        self.init()

       translatesAutoresizingMaskIntoConstraints = false
       setTitle(title, for: .normal)
       setTitleColor(tintColor, for: .normal)
       titleLabel?.font = font
       self.backgroundColor = backgroundColor
       
    }
    
}
