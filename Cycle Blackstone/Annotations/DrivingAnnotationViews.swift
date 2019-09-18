//
//  DrivingAnnotationViews.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 4/23/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import Foundation
import MapKit

class DrivingAnnotationMarkerView: MKMarkerAnnotationView {
    
    //This is for the directional annotation
    override var annotation: MKAnnotation? {
        willSet {
            guard let drivingAnnotation = newValue as? DrivingAnnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton
            markerTintColor = drivingAnnotation.markerTintColor
            if let imageName = drivingAnnotation.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
                glyphText = String(drivingAnnotation.poiType.first!)
            }
        }
    }
}

class DrivingAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let drivingAnnotation = newValue as? DrivingAnnotation else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = drivingAnnotation.locationName
            detailCalloutAccessoryView = detailLabel
            
            if let imageName = drivingAnnotation.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
        }
    }
}
