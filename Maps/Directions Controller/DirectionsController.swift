//
//  DirectionsController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit


class DirectionsController: UIViewController {
    
    let mapView = MKMapView()
    var navBar = UIView().createNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setupNavBarUI()
        setupMapView()
        setupRegionForMap()
        requestForDirections()

    }
    
    private func requestForDirections() {
        
        let request = MKDirections.Request()
        
        let startingPlacemark = MKPlacemark(coordinate: .init(latitude: 53.893009, longitude: 27.567444))
        let endingPlacemark = MKPlacemark(coordinate: .init(latitude: 52.097622, longitude: 23.734051))
        
        request.source = .init(placemark: startingPlacemark)
        request.destination = .init(placemark: endingPlacemark)
        
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            
            if let error = error {
                print("Failed to find routing info", error)
                return
            }
            
            guard let route = response?.routes.first else { return }
            
//            print(route.expectedTravelTime)
//            print(route.distance)
//            print(route.name)
//            print(route.steps)
            
            self.mapView.addOverlay(route.polyline)
        }
    }
    
    private func setupMapView() {
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupRegionForMap() {
        
        let location = CLLocationCoordinate2D(
                        latitude: 53.893009,
                        longitude: 27.567444)
        
        let span = MKCoordinateSpan(
                        latitudeDelta: 0.5,
                        longitudeDelta: 0.5)
        
        let region = MKCoordinateRegion(
                        center: location,
                        span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func setupTextFields(firstTF: UITextField, secondTF: UITextField) {
        
        firstTF.attributedPlaceholder = NSAttributedString().createCustomPlaceholder(text: "Start", textColor: .white)
        secondTF.attributedPlaceholder = NSAttributedString().createCustomPlaceholder(text: "End", textColor: .white)

        [firstTF, secondTF].forEach { (textField) in
           textField.layer.cornerRadius = 5
           textField.textColor = .white
           textField.font = UIFont.boldSystemFont(ofSize: 16)
           textField.backgroundColor = .init(white: 1, alpha: 0.3)
       }
    }
    
    private func setupNavBarUI() {
        
        view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
        ])
       
        let startTextField = MapsSearchField().buildSearchField()
        let endTextField = MapsSearchField().buildSearchField()
        setupTextFields(firstTF: startTextField, secondTF: endTextField)

        let stackView = UIStackView(axis: .vertical, spacing: 12, distribution: .fillEqually)
        stackView.addArrangedSubview(startTextField)
        stackView.addArrangedSubview(endTextField)

        navBar.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 36),
            stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.topAnchor, constant: 12),
        ])

        let startImage = UIImageView(image: #imageLiteral(resourceName: "start").withTintColor(.white), contentMode: .scaleAspectFit)
        
        navBar.addSubview(startImage)
        NSLayoutConstraint.activate([
            startImage.centerYAnchor.constraint(equalTo: startTextField.centerYAnchor),
            startImage.widthAnchor.constraint(equalToConstant: 25),
            startImage.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 6)

        ])
        
        let endImage = UIImageView(image: #imageLiteral(resourceName: "end").withTintColor(.white), contentMode: .scaleAspectFit)
        
        navBar.addSubview(endImage)
        NSLayoutConstraint.activate([
            endImage.centerYAnchor.constraint(equalTo: endTextField.centerYAnchor),
            endImage.widthAnchor.constraint(equalToConstant: 25),
            endImage.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 6)
        
        ])
    }
}

