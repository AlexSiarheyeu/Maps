//
//  MKMapItem+Address.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/31/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

//import UIKit

import MapKit

extension MKMapItem {
    
    func address() -> String {
        var address = ""
        
        if placemark.subThoroughfare != nil {
            address = placemark.subThoroughfare! + " "
        }
        if placemark.thoroughfare != nil {
            address = placemark.thoroughfare! + ", "
        }
        if placemark.postalCode != nil {
            address = placemark.postalCode! + ", "
        }
        if placemark.locality != nil {
            address = placemark.locality! + ", "
        }
        if placemark.administrativeArea != nil {
            address = placemark.administrativeArea! + ", "
        }
        if placemark.country != nil {
            address = placemark.country! + " "
        }
        return address
    }
}
