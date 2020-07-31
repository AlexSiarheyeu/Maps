//
//  MapsSearchField.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class MapsSearchField {
    
    func buildSearchField(placeholder: String = "Search", backgroundColor: UIColor = .white) -> UITextField {
        
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = backgroundColor
        
        textField.placeholder = placeholder
        
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        
        return textField
    }
 
}



