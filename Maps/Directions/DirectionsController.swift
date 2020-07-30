//
//  DirectionsController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

extension DirectionsController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = #colorLiteral(red: 0.1254901961, green: 0.5529411765, blue: 0.9529411765, alpha: 1)
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
}

class DirectionsController: UIViewController {
    
    let mapView = MKMapView()
    let navBar = UIView().createNavigationBar()

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
   

    private func setupNavBarUI() {
        
        view.addSubview(navBar)

        NSLayoutConstraint.activate([
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        ])
       
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        navBar.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.topAnchor),
        ])
        
        let startTextField = MapsSearchField().buildSearchField(placeholder: "Start", backgroundColor: .clear)
        let endTextField = MapsSearchField().buildSearchField(placeholder: "End", backgroundColor: .clear)

        stackView.addArrangedSubview(startTextField)
        stackView.addArrangedSubview(endTextField)

    }
}

extension UIView {
    
    func createNavigationBar() -> UIView {
        let navigationView = UIView()
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.5568627451, blue: 0.9568627451, alpha: 1)

        navigationView.layer.shadowOffset = CGSize(width: 10,
                                        height: 10)
        navigationView.layer.shadowRadius = 5
        navigationView.layer.shadowOpacity = 0.1
       
        return navigationView
    }
}
