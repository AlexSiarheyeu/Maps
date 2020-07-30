//
//  MainController+MapView.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

extension MainController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKPointAnnotation) {

            let annotationView = MKPinAnnotationView(
                                 annotation: annotation,
                                 reuseIdentifier: "id")

            annotationView.canShowCallout = true

            return annotationView
        }
        return nil
        
    }
}
