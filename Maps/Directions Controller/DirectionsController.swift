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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true

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
            //print(route.expectedTravelTime) print(route.distance) print(route.name) print(route.steps)
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
    
    private func setupTextFieldsView(firstTF: UITextField, secondTF: UITextField) {
        
        firstTF.attributedPlaceholder = NSAttributedString().createCustomPlaceholder(text: "Start", textColor: .white)
        secondTF.attributedPlaceholder = NSAttributedString().createCustomPlaceholder(text: "End", textColor: .white)
    }
    
    let startTextField = MapsSearchField().buildSearchField()
    let endTextField = MapsSearchField().buildSearchField()

    private func setupNavBarUI() {
        
        let stackView = UIStackView(axis: .vertical,
                                    spacing: 12,
                                    distribution: .fillEqually)
        
        startTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChooseStartPoint)))
        endTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChooseEndPoint)))

        setupTextFieldsView(firstTF: startTextField, secondTF: endTextField)
               
        stackView.addArrangedSubview(startTextField)
        stackView.addArrangedSubview(endTextField)
        
        view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
        ])
       
        navBar.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 36),
            stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.topAnchor, constant: 12),
        ])

        let startPointImage = UIImageView(image: #imageLiteral(resourceName: "start").withTintColor(.white), contentMode: .scaleAspectFit)
        navBar.addSubview(startPointImage)
        NSLayoutConstraint.activate([
            startPointImage.centerYAnchor.constraint(equalTo: startTextField.centerYAnchor),
            startPointImage.widthAnchor.constraint(equalToConstant: 25),
            startPointImage.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 6)
        ])
        
        let endPointImage = UIImageView(image: #imageLiteral(resourceName: "end").withTintColor(.white), contentMode: .scaleAspectFit)
        navBar.addSubview(endPointImage)
        NSLayoutConstraint.activate([
            endPointImage.centerYAnchor.constraint(equalTo: endTextField.centerYAnchor),
            endPointImage.widthAnchor.constraint(equalToConstant: 25),
            endPointImage.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 6)
        ])
    }
    
    @objc private func handleChooseStartPoint () {
        
        let locationsVC = LocationSearchController(collectionViewLayout: UICollectionViewFlowLayout())
        locationsVC.selectionHandler = { [weak self] mapItem in
            self?.startTextField.text = mapItem.name
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(locationsVC, animated: true)
    }
    
    @objc private func handleChooseEndPoint() {
        
        let locationsVC = LocationSearchController(collectionViewLayout: UICollectionViewFlowLayout())
        locationsVC.selectionHandler = { [weak self] mapItem in
            self?.endTextField.text = mapItem.name
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(locationsVC, animated: true)
        }
    
}

