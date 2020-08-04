//
//  ViewController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

class MainController: UIViewController {
    
    //MARK: Properties
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let searchTextField = UITextField(placeholder: "Search",
                                      backgroundColor: .white,
                                      cornerRadius: 5,
                                      textColor: .black,
                                      font: UIFont.boldSystemFont(ofSize: 16),
                                      borderWidth: 1)

    //MARK: View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        setupMapView()
        setupRegionForMap()
        setupAnnotationsForMap()
        setupSearchUI()
        requestUserLocation()
        setupGetDirectionsButton()
   }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Private methods and selectors implementationn
    
    private func setupGetDirectionsButton() {
        
        let getDirections = UIButton(title: "Get directions to",
                                    tintColor: .black,
                                    font: UIFont.boldSystemFont(ofSize: 16),
                                    backgroundColor: .white)
        
        getDirections.addTarget(self, action: #selector(showDirectionsController), for: .touchUpInside)
        
        view.addSubview(getDirections)
        NSLayoutConstraint.activate([
            getDirections.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            getDirections.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            getDirections.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            getDirections.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func showDirectionsController() {
        let directionsController = DirectionsController()
        navigationController?.pushViewController(directionsController, animated: true)
    }
    
    private func  requestUserLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func setupMapView() {
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
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
    
    private func setupAnnotationsForMap() {
        mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    private func setupSearchUI() {
        
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
           searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
           searchTextField.heightAnchor.constraint(equalToConstant: 50)
       ])
        
        searchTextField.addTarget(self, action:
                                        #selector(handleSearchChanges),
                                        for: .editingDidEndOnExit)
        }
    
    @objc func handleSearchChanges() {
        performLocalSearch()
    }
}

