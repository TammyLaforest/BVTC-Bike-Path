//
//  AppleMapViewController.swift
//  Cycle Blackstone
//
//  Created by Christian Laiter on 3/5/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

//import UIKit
//import MapKit
//
//class BikePathMapViewController: UIViewController {
//    
////    var selectedOptions : [MapOptionsType] = []
//    var bikePath = BikePath(filename: "BikePath")
//    var polyLineArray = [MKPolyline]()
//    var foodPOIArray = [[String:String]]()
//    var sightPOIArray = [[String:String]]()
//    var shopPOIArray = [[String:String]]()
//    var parkingPOIArray = [[String:String]]()
//    let testingApp = true
//    
//    @IBOutlet weak var mapView: MKMapView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let latDelta = bikePath.overlayTopLeftCoordinate.latitude -
//            bikePath.overlayBottomRightCoordinate.latitude
//
//        // Think of a span as a tv size, measure from one corner to another
//        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
//        let region = MKCoordinateRegionMake(bikePath.midCoordinate, span)
//        
//        mapView.region = region
//        
//        parsePOIPins()
//        
//        if testingApp {
//            addBikePath()
//            addFood()
//            addSights()
//            addShops()
//            addParking()
//        }
//        else {
//            addBikePath()
//        }
//        
//        
//    }
//    
//    
//    func addRoute(_ plist:String) {
//        guard let points = BikePath.plist(plist) as? [String] else { return }
//        
//        let cgPoints = points.map { CGPointFromString($0) }
//        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
//        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
//        
//        polyLineArray.append(myPolyline)
//        
//        mapView.add(myPolyline)
//    }
//    
//    //Load the plist files to show the bike path
//    func addBikePath(){
//        addRoute("Multi-Use1")
//        addRoute("Multi-Use2")
//        addRoute("Multi-Use3")
//        addRoute("Multi-Use4")
//        addRoute("Multi-Use5")
//        addRoute("Multi-Use6")
//        addRoute("OnRoadBikeLane1")
//        addRoute("OnRoadBikeLane2")
//        addRoute("OnRoadSharrow1")
//        addRoute("OnRoadSharrow2")
//        addRoute("OnRoadSharrow3")
//        addRoute("OnRoadSharrow4")
//        addRoute("OnRoadSharrow5")
//        addRoute("OnRoadSharrow6")
//    }
//    
//    func addFood() {
//        for poi in foodPOIArray {
//            let coordinate = BikePath.parseCoord(dict: poi as [String : Any], fieldName: "location")
//            let title = poi["name"] ?? ""
//            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
//            let type = POIType(rawValue: typeRawValue) ?? .food
//            let subtitle = poi["phone"] ?? ""
//            let annotation = POIAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
//            mapView.addAnnotation(annotation)
//        }
//    }
//    
//    func addSights() {
//        for poi in sightPOIArray {
//            let coordinate = BikePath.parseCoord(dict: poi as [String : Any], fieldName: "location")
//            let title = poi["name"] ?? ""
//            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
//            let type = POIType(rawValue: typeRawValue) ?? .food
//            let subtitle = poi["phone"] ?? ""
//            let annotation = POIAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
//            mapView.addAnnotation(annotation)
//        }
//    }
//    
//    func addShops() {
//        for poi in shopPOIArray {
//            let coordinate = BikePath.parseCoord(dict: poi as [String : Any], fieldName: "location")
//            let title = poi["name"] ?? ""
//            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
//            let type = POIType(rawValue: typeRawValue) ?? .food
//            let subtitle = poi["phone"] ?? ""
//            let annotation = POIAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
//            mapView.addAnnotation(annotation)
//        }
//    }
//    
//    func addParking() {
//        for poi in parkingPOIArray {
//            let coordinate = BikePath.parseCoord(dict: poi as [String : Any], fieldName: "location")
//            let title = poi["name"] ?? ""
//            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
//            let type = POIType(rawValue: typeRawValue) ?? .food
//            let subtitle = poi["phone"] ?? ""
//            let annotation = POIAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
//            mapView.addAnnotation(annotation)
//        }
//    }
//    
//    func loadSelectedOptions() {
//        mapView.removeAnnotations(mapView.annotations)
//        mapView.removeOverlays(mapView.overlays)
//        
//        for polyline in polyLineArray{
//            mapView.add(polyline)
//        }
//        
//        
//        for option in selectedOptions {
//            switch (option) {
//            case .mapFood:
//                addFood()
//            case .mapSights:
//                addSights()
//            case .mapShops:
//                addShops()
//            case .mapParking:
//                addParking()
//            }
//        }
//    }
//    
// 
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
//        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
//    }
//    
//    func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
//        guard let a = a as? T, let b = b as? T else { return nil }
//        
//        return a == b
//    }
//    
//    func parsePOIPins() {
//        guard let pois = BikePath.plist("PointsOfInterest") as? [[String : String]] else { return }
//        
//        for poi in pois {
////            let coordinate = BikePath.parseCoord(dict: poi, fieldName: "location")
////            let title = poi["name"] ?? ""
////            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
////            let type = POIType(rawValue: typeRawValue) ?? .misc
////            let subtitle = poi["phone"] ?? ""
////            let annotation = POIAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
////            mapView.addAnnotation(annotation)
//            let typeRawValue = Int(poi["type"] ?? "0") ?? 0
//            
//            switch (typeRawValue) {
//            case 0:
//                foodPOIArray.append(poi)
//            case 1:
//                sightPOIArray.append(poi)
//            case 2:
//                shopPOIArray.append(poi)
//            case 3:
//                parkingPOIArray.append(poi)
//            default:
//                break
//            }
//            
//        }
//    }
//    
//    
//}
//
//extension BikePathMapViewController: MKMapViewDelegate {
//  
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//
//        if overlay is MKPolyline {
//            let lineView = MKPolylineRenderer(overlay: overlay)
//            if isEqual(type: MKPolyline.self, a: polyLineArray[0], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[1], b: overlay)! ||
//                isEqual(type: MKPolyline.self, a: polyLineArray[2], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[3], b: overlay)! ||
//                isEqual(type: MKPolyline.self, a: polyLineArray[4], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[5], b: overlay)!
//            {
//                lineView.strokeColor = UIColor.green
//            }
//            else if isEqual(type: MKPolyline.self, a: polyLineArray[6], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[7], b: overlay)!{
//                lineView.strokeColor = UIColor.blue
//            }
//            else {
//                lineView.strokeColor = UIColor.purple
//            }
//            lineView.lineWidth = 5.0
//            return lineView
//        }
//        
//        return MKOverlayRenderer()
//    }
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
////        let annotationView = POIAnnotationView(annotation: annotation, reuseIdentifier: "POI")
////        annotationView.canShowCallout = true
//        
//        
//        if annotation is MKUserLocation {
//            return nil
//        }
//        
//        let identifier = "POI"
//        var annotationView : POIAnnotationView
//        
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? POIAnnotationView{
//            dequeuedView.annotation = annotation
//            annotationView = dequeuedView
//        } else {
//            annotationView = POIAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView.canShowCallout = true
//            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
//            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        
//        return annotationView
//        
//    }
//    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
//                 calloutAccessoryControlTapped control: UIControl) {
//        if control == view.rightCalloutAccessoryView {
//            performSegue(withIdentifier: "AnnotationDetailsSegue", sender: self)
//            
//        }
//    }
//    
//    
//}
