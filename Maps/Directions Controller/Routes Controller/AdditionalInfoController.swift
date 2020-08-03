//
//  RoutesController.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

class AdditionalInfoController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var mapItems: MKRoute? = nil {
        didSet {
            
            guard let mapItem = mapItems else {return}
            
                let kmDistance = mapItem.distance/1000
                let formatKmDistance = String(format: "%.2f", kmDistance)
           
            distanceLabel.attributedText = NSAttributedString().generateAttributedString(title: "Distance  ", description: "\(formatKmDistance) km")
            
                let timeString = MKMapItem().generateRepresentableTime(route: mapItem)
           
            travelTimeLabel.attributedText = NSAttributedString().generateAttributedString(title: "Estimated time  ", description: "\(timeString)")
            
            destinationStreetLabel.attributedText = NSAttributedString().generateAttributedString(title: "End point  ", description: "\(mapItem.name)")
        }
    }
    
    let stackView: UIStackView = {
        let stack = UIStackView(axis: .vertical, spacing: 0, distribution: .fillEqually)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let travelTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let destinationStreetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.roundedTopCorners()
        view.backgroundColor = .white
       
        setupSwipeGestureForController()
        setupStackView()
    }
    
    @objc private func handleDismiss() {
        dismiss(animated: true)
    }
    
    private func setupSwipeGestureForController() {
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    private func setupStackView() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(distanceLabel)
        stackView.addArrangedSubview(travelTimeLabel)
        stackView.addArrangedSubview(destinationStreetLabel)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height*0.25),
        ])
    }
}

