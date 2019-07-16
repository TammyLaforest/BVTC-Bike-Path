//
//  PointOfInterest.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 4/23/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class PointOfInterest: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let poiType: String
    let coordinate: CLLocationCoordinate2D
    let id: Int
    let hours: String
    let phone: String
    let address: String
    let town: String
    let website: String
    
    init(title: String, locationName: String, poiType: String, coordinate: CLLocationCoordinate2D, id: Int, hours:String, phone:String, address:String, town:String, website:String ) {
        self.title = title
        self.locationName = locationName
        self.poiType = poiType
        self.coordinate = coordinate
        self.id = id
        self.hours = hours
        self.phone = phone
        self.address = address
        self.town = town
        self.website = website

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
    
    // markerTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch poiType {
        case "eat": //Food
            return .red
        case "see": //Sightseeing
            return .green
        case "shop": //Shopping
            return .orange
        case "park":  //Parking
            return .blue
        default:
            return .blue
        }
    }
    
    var imageName: String? {
        switch poiType {
        case "eat":
            return "Food"
        case "see":
            return "Sight"
        case "shop":
            return "Shop"
        case "park":
            return nil
        default:
            return nil
        }
    }
    
}
