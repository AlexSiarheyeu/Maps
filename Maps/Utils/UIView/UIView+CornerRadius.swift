//
//  UIView+CornerRadius.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/3/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UIView{
    
    func roundedTopCorners(){
        let bezierPath = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: [.topLeft , .topRight],
                                      cornerRadii: CGSize(width: 36, height: 36))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = bezierPath.cgPath
        layer.mask = maskLayer
    }
}
