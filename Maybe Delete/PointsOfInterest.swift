//
//  PointsOfInterest.swift
//  Cycle Blackstone
//
//  Created by Christian Laiter on 3/4/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit
import MapKit

struct PointOfInterest1 {
    
    let name : String
//    var town : String?
    let long : CLLocationDegrees
    let lat : CLLocationDegrees
//    var street : String?
//    var website : String?
//    var phone : String?
    
    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.long = long
        self.lat = lat
        print("made the entry")
    }
    
    
    
    
}
