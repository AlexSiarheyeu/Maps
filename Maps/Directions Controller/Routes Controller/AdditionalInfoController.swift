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
           
            let attributedText = NSMutableAttributedString(string: " Distance ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(NSMutableAttributedString(string: "                                                "))
            attributedText.append(NSAttributedString(string: " \(formatKmDistance) km", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            distanceLabel.attributedText = attributedText
            
            var timeString = ""
            if mapItem.expectedTravelTime > 3600 {
                let hours = Int(mapItem.expectedTravelTime / 60 / 60)
                let minutes = Int(mapItem.expectedTravelTime.truncatingRemainder(dividingBy: 60 * 60)/60)
                timeString = String(format: "%d hr %d min", hours, minutes)
            } else {
                let time = Int(mapItem.expectedTravelTime / 60)
                timeString = String(format: "%d min", time)
            }
            
            let attributedText1 = NSMutableAttributedString(string: " Estimated time ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText1.append(NSMutableAttributedString(string: "                                       "))
            attributedText1.append(NSAttributedString(string: " \(timeString) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            
            travelTimeLabel.attributedText = attributedText1
            
            let attributedText2 = NSMutableAttributedString(string: " End point ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText2.append(NSMutableAttributedString(string: "                                                "))
            attributedText2.append(NSAttributedString(string: " \(mapItem.name) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            
            destinationStreetLabel.attributedText = attributedText2
            
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
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
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
    
    @objc private func handleDismiss() {
        dismiss(animated: true)
    }
}

