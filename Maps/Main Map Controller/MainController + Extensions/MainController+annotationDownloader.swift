//
//  MainController+annotationDownloader.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/4/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

extension MainController {
    
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
                               
                })
            
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
}
