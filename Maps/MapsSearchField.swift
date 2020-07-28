//
//  MapsSearchField.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class MapsSearchField {
    
    var placeholder: String
    var backgroundColor: UIColor
    
    init() {
        self.placeholder = "Search"
        self.backgroundColor = .white
    }
    
    func buildSearchField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = backgroundColor
        textField.placeholder = placeholder
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        return textField
    }
 
}


