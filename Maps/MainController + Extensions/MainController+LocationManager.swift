//
//  MainController+LocationManager.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import CoreLocation

extension MainController: CLLocationManagerDelegate {
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {

        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
       default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let firstLocation = locations.first else { return }
        
        mapView.setRegion(.init(center: firstLocation.coordinate,
                                span: .init(latitudeDelta: 0.1,
                                            longitudeDelta: 0.1)), animated: false)
    }
}
