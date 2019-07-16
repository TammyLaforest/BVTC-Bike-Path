//
//  BikePathAnnotations.swift
//  Cycle Blackstone
//
//  Created by Christian Laiter on 3/6/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit
import MapKit

enum POIType: Int {
    case food = 0
    case sight
    case shop
    case parking
    
    func image() -> UIImage {
        switch self {
        case .food:
            return #imageLiteral(resourceName: "food")
        case .sight:
            return #imageLiteral(resourceName: "star")
        case .shop:
            return #imageLiteral(resourceName: "shop")
        case .parking:
            return #imageLiteral(resourceName: "parking")
        }
    }
}

class POIAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: POIType
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: POIType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}
