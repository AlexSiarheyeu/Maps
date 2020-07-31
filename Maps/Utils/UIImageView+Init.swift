//
//  UIImageView+Init.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/31/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
