//
//  NSMutableAttributedString+CustomAttrString.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/3/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func generateAttributedString(title: String, description: String) -> NSAttributedString {

        let attributedText = NSMutableAttributedString(string: title,
                                                       attributes: [NSAttributedString.Key.font:
                                                                    UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: description,
                                                 attributes: [NSAttributedString.Key.foregroundColor:
                                                              UIColor.lightGray,
                                                              
                                                              NSAttributedString.Key.font:
                                                              UIFont.systemFont(ofSize: 18)]))

        return attributedText
    }
}
