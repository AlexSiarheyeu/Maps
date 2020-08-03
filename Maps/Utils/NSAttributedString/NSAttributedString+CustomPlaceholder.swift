//
//  NSAttributedString+CustomPlaceholder.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/31/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

enum Color {
    case white, black, blue
}

extension NSAttributedString {
    
     func createCustomPlaceholder(text: String,
                                  textColor: Color) -> NSAttributedString {
        
        var attributes = [Key: Any]()
        var resultString = NSAttributedString(string: text,
                                              attributes: attributes)
        
        switch textColor {
            
            case .white:
                
                attributes = [.foregroundColor : UIColor.white]
                resultString = NSAttributedString(string: text,
                                                  attributes: attributes)
                return resultString
            
            case .black:
                
                attributes = [.foregroundColor : UIColor.black]
                resultString = NSAttributedString(string: text,
                                                  attributes: attributes)
                return resultString
            
            case .blue:
                
                attributes = [.foregroundColor : UIColor.blue]
                resultString = NSAttributedString(string: text,
                                                  attributes: attributes)
                return resultString
        }

    }
    
}
