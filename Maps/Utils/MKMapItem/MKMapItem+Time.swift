//
//  MKMapItem+Time.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/4/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import MapKit

extension MKMapItem {
    
    func generateRepresentableTime(route: MKRoute) -> String {
         
        var timeString = ""
        
        if route.expectedTravelTime > 3600 {
            
           let hours = Int(route.expectedTravelTime / 60 / 60)
            
           let minutes = Int(route.expectedTravelTime.truncatingRemainder(dividingBy: 60 * 60)/60)
            
           timeString = String(format: "%d hr %d min", hours, minutes)
            
       } else {
            
           let time = Int(route.expectedTravelTime / 60)
            
           timeString = String(format: "%d min", time)
       }
        
        return timeString
    }
}
