//
//  UITextField+Insets.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
