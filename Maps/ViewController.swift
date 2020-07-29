//
//  ViewController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setupMapView()
        setupRegionForMap()
        setupAnnotationsForMap()
        setupSearchUI()
        setupLocationCarousel()
        
   }

    func setupMapView() {
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupRegionForMap() {
        
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
    
    func setupAnnotationsForMap() {
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(
                                    latitude: 53.893009,
                                    longitude: 27.567444)
        
        annotation.title = "Minsk"
        
        mapView.addAnnotation(annotation)
        
        mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    var controller = MapsCollectionViewCarousel()
    func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTextField.text
        request.region = mapView.region
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { (response, error) in

            if let error = error {
                print("Failed local search", error)
                return
            }
            
            //success
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            response?.mapItems.forEach({ [weak self] (mapItem) in
                
                let annotation =  MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self?.mapView.addAnnotation(annotation)
                
                self?.controller.item.append(mapItem)
                })
            
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    

    let searchTextField = MapsSearchField().buildSearchField()

    func setupSearchUI() {
        
        view.addSubview(searchTextField)

        NSLayoutConstraint.activate([
           searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 34),
           searchTextField.heightAnchor.constraint(equalToConstant: 50)
       ])
        
        searchTextField.addTarget(self, action:
                                        #selector(handleSearchChanges),
                                        for: .editingDidEndOnExit)
        }
    
    @objc func handleSearchChanges() {
        performLocalSearch()
    }
    
    func setupLocationCarousel() {
        
        let collectionCarousel = MapsCollectionViewCarousel()
        
        mapView.addSubview(collectionCarousel)
        NSLayoutConstraint.activate([
            collectionCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionCarousel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            collectionCarousel.heightAnchor.constraint(equalToConstant: 150)
        ])
   
    }
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(
                             annotation:  annotation,
                             reuseIdentifier: "id")
        
        annotationView.canShowCallout = true

        return annotationView
    }
}
