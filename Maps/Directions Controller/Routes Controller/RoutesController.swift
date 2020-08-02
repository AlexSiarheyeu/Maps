//
//  RoutesController.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit



class RoutesController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var mapItems = [MKRoute.Step]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.roundedTopCorners()
        view.backgroundColor = .blue
    }
}

