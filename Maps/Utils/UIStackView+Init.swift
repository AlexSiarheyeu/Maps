//
//  UIStackView+Init.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/31/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: Distribution) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
}
