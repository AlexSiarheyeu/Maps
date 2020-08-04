//
//  UIView+NavBar.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UIView {
    
    func createNavigationBar() -> UIView {
        
        let navigationView = UIView()
        navigationView.backgroundColor = .red
        navigationView.frame = CGRect(x: 0, y: 0, width: .max , height: 100)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.5568627451, blue: 0.9568627451, alpha: 1)

        navigationView.layer.shadowOffset = CGSize(width: 10,
                                                   height: 10)
        navigationView.layer.shadowRadius = 5
        navigationView.layer.shadowOpacity = 0.1
        
        return navigationView
    }
}

