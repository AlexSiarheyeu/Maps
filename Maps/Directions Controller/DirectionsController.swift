//
//  DirectionsController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit
import JGProgressHUD

class DirectionsController: UIViewController {
    
    let mapView = MKMapView()
    var navBar = UIView().createNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setupNavBarUI()
        setupMapView()
        setupRegionForMap()
        //requestForDirections()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true

    }
    
    private func requestForDirections() {
        
        let progressIndicator = JGProgressHUD(style: .dark)
        progressIndicator.textLabel.text = "Routing..."
        progressIndicator.show(in: view)
        
        let request = MKDirections.Request()
        
        request.source = startMapItem
        request.destination = endMapItem
        
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            
            progressIndicator.dismiss(animated: true)
            
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
    
    let startTextField = UITextField.init(placeholder: "Start point", backgroundColor: .init(white: 1, alpha: 0.3), cornerRadius: 5, textColor: .white, font: .boldSystemFont(ofSize: 16))
    
    let endTextField = UITextField.init(placeholder: "Start point", backgroundColor: .init(white: 1, alpha: 0.3), cornerRadius: 5, textColor: .white, font: .boldSystemFont(ofSize: 16))

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
    
    var startMapItem: MKMapItem?
    var endMapItem: MKMapItem?
    
    @objc private func handleChooseStartPoint () {
        
        let locationsVC = LocationSearchController(collectionViewLayout: UICollectionViewFlowLayout())
        locationsVC.selectionHandler = { [weak self] mapItem in
            self?.startTextField.text = mapItem.name
            
            self?.startMapItem = mapItem
            self?.refreshMap()
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(locationsVC, animated: true)
    }
    
    @objc private func handleChooseEndPoint() {
        
        let locationsVC = LocationSearchController(collectionViewLayout: UICollectionViewFlowLayout())
        locationsVC.selectionHandler = { [weak self] mapItem in
            self?.endTextField.text = mapItem.name
            
            self?.endMapItem = mapItem
            self?.refreshMap()
        
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(locationsVC, animated: true)
        }
    
    private func refreshMap() {
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        if let startMapItem = startMapItem {
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = startMapItem.placemark.coordinate
            annotation.title = startMapItem.name
            mapView.addAnnotation(annotation)
        }
        
        if let endMapItem = endMapItem {
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = endMapItem.placemark.coordinate
            annotation.title = endMapItem.name
            mapView.addAnnotation(annotation)
        }
        
        requestForDirections()
        mapView.showAnnotations(mapView.annotations, animated: false)

    }
}

