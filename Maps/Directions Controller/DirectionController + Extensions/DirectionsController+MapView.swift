//
//  DirectionsController+MapView.swift
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
