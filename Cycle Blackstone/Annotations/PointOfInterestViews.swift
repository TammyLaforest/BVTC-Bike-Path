//
//  PointOfInterestViews.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 4/23/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import Foundation
import MapKit

class PointOfInterestkMarkerView: MKMarkerAnnotationView {
    
    //This is for the informational annotation
//    override var annotation: MKAnnotation? {
//        willSet {
//            guard let pointOfInterest = newValue as? PointOfInterest else { return }
//            canShowCallout = true
//            calloutOffset = CGPoint(x: -5, y: 5)
//            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            markerTintColor = pointOfInterest.markerTintColor
//            if let imageName = pointOfInterest.imageName {
//                glyphImage = UIImage(named: imageName)
//            } else {
//                glyphImage = nil
//                glyphText = String(pointOfInterest.poiType.first!)
//            }
//        }
//    }
    
    //This is for the directional annotation
    override var annotation: MKAnnotation? {
        willSet {
            guard let pointOfInterest = newValue as? PointOfInterest else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            markerTintColor = pointOfInterest.markerTintColor
            if let imageName = pointOfInterest.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
                glyphText = String(pointOfInterest.poiType.first!)
            }
        }
    }
}

class PointOfInterestView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let pointOfInterest = newValue as? PointOfInterest else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = pointOfInterest.locationName
            detailCalloutAccessoryView = detailLabel
            
            if let imageName = pointOfInterest.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
        }
    }
}
