//
//  DrivingAnnotation.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 4/23/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class DrivingAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let poiType: String
    let coordinate: CLLocationCoordinate2D
    
    
    init(title: String, locationName: String, poiType: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.poiType = poiType
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: locationName]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    var subtitle: String? {
        return locationName
    }
    
    var markerTintColor: UIColor  {
        switch poiType {
        case "Food":
            return .red
        case "Sight":
            return .green
        case "Shop":
            return .orange
        case "Park":
            return .blue
        default:
            return .cyan
        }
    }
    
    var imageName: String? {
        switch poiType {
        case "Food":
            return poiType
        case "Sight":
            return poiType
        case "Shop":
            return poiType
        case "Park":
            return nil
        default:
            return poiType
        }
    }
    
}
