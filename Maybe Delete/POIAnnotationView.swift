//
//  POIAnnotationView.swift
//  Cycle Blackstone
//
//  Created by Christian Laiter on 3/6/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit
import MapKit

class POIAnnotationView: MKAnnotationView {
    // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard let poiAnnotation = self.annotation as? POIAnnotation else { return }
        
        image = poiAnnotation.type.image()
    }
}
