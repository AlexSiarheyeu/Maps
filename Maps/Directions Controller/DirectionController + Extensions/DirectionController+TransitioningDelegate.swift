//
//  DirectionController+TransitioningDelegate.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/3/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension DirectionsController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfPresentationController(presentedViewController: presented, presenting: presenting)
    }
    

    
}

class HalfPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        
        let rect = CGRect(x: 0, y: containerView!.bounds.height/1.4, width: containerView!.bounds.width, height: containerView!.bounds.height)
        return rect
    }
  

}
