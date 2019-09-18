//
//  BikePathViewController.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 4/23/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import Foundation
import MapKit

var pointsOfInterest: [PointOfInterest] = []
var initialDataLoaded = false

class BikePathViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapDisplaySegmentControl: UISegmentedControl!
    
    
    var drivingAnnotations: [DrivingAnnotation] = []
    var polyLineArray: [MKPolyline] = []
    var selectedOptions : [MapOptionsType] = [.mapFood, .mapSights, .mapShops, .mapParking]
    var showPOIType: [Bool] = [true, true, true, true]
    var buttonChosen = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location of the bike path
        let initialLocation = CLLocation(latitude: 41.903299, longitude: -71.454511)
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        mapView.register(PointOfInterestkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        addBikePath()
        
        if !initialDataLoaded{
            loadInitialData()
            pointsOfInterest = pointsOfInterest.sorted{$0.title! < $1.title!}
        }
        mapView.addAnnotations(pointsOfInterest)
        mapView.addAnnotations(drivingAnnotations)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    func loadInitialData() {
        
        guard let pois = BikePath.plist("PointsOfInterest") as? [[String : String]] else { return }
        var counter = 0
        
        for poi in pois {
            
            let type = poi["type"]
            let coordinate = BikePath.parseCoord(dict: poi as [String : Any], fieldName: "location")
            
            switch (type) {
            case "eat": //Food
                if showPOIType[0] {
                    let point = PointOfInterest(title: poi["name"]!, locationName: poi["typeOfLocation"]!, poiType: poi["type"]!, coordinate: coordinate, id: counter, hours: poi["hours"]!, phone: poi["phone"]!, address: poi["address"]!, town: poi["town"]!, website: poi["website"]!)
                    pointsOfInterest.append(point)
                }
            case "see": //Sightseeing
                if showPOIType[1] {
                    let point = PointOfInterest(title: poi["name"]!, locationName: poi["typeOfLocation"]!, poiType: poi["type"]!, coordinate: coordinate, id: counter, hours: poi["hours"]!, phone: poi["phone"]!, address: poi["address"]!, town: poi["town"]!, website: poi["website"]!)
                    pointsOfInterest.append(point)
                }
            case "shop": //Shopping
                if showPOIType[2] {
                    let point = PointOfInterest(title: poi["name"]!, locationName: poi["typeOfLocation"]!, poiType: poi["type"]!, coordinate: coordinate, id: counter, hours: poi["hours"]!, phone: poi["phone"]!, address: poi["address"]!, town: poi["town"]!, website: poi["website"]!)
                    pointsOfInterest.append(point)
                }
            case "park": //Parking
                if showPOIType[3] {
//                    let point = DrivingAnnotation(title: poi["name"]!, locationName: poi["address"]!, poiType: poi["type"]!, coordinate: coordinate)
//                    drivingAnnotations.append(point)
                    let point = PointOfInterest(title: poi["name"]!, locationName: poi["typeOfLocation"]!, poiType: "Park", coordinate: coordinate, id: counter, hours: poi["hours"]!, phone: poi["phone"]!, address: poi["address"]!, town: poi["town"]!, website: poi["website"]!)
                    pointsOfInterest.append(point)
                    
                }
            default:
                break
            }
            counter = counter + 1
        }
        initialDataLoaded = true
    }
    
    let regionRadius: CLLocationDistance = 20000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addRoute(_ plist:String) {
        guard let points = BikePath.plist(plist) as? [String] else { return }
        
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
        
        polyLineArray.append(myPolyline)
        
        mapView.addOverlay(myPolyline)
        
    }
    
    func addBikePath(){
        addRoute("Multi-Use1")
        addRoute("Multi-Use2")
        addRoute("Multi-Use3")
        addRoute("Multi-Use4")
        addRoute("Multi-Use5")
        addRoute("Multi-Use6")
        addRoute("OnRoadBikeLane1")
        addRoute("OnRoadBikeLane2")
        addRoute("OnRoadSharrow1")
        addRoute("OnRoadSharrow2")
        addRoute("OnRoadSharrow3")
        addRoute("OnRoadSharrow4")
        addRoute("OnRoadSharrow5")
        addRoute("OnRoadSharrow6")
    }
    
    func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        guard let a = a as? T, let b = b as? T else { return nil }
        
        return a == b
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OptionsSegue"{
            (segue.destination as? MapOptionsViewController)?.selectedOptions = selectedOptions
        }
        if segue.identifier == "AnnotationDetailsSegue"{
            (segue.destination as? AnnotationDetailsViewController)?.selectedLocation = buttonChosen
        }
        
    }

    @IBAction func closeOptions(_ exitSegue: UIStoryboardSegue) {
        guard let vc = exitSegue.source as? MapOptionsViewController else { return }
        selectedOptions = vc.selectedOptions
        loadSelectedOptions()
    }
    
    func loadSelectedOptions() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        pointsOfInterest.removeAll()
        
        showPOIType[0] = false
        showPOIType[1] = false
        showPOIType[2] = false
        showPOIType[3] = false
        
        for option in selectedOptions {
            
            switch (option) {
            case .mapFood:
                showPOIType[0] = true
            case .mapSights:
                showPOIType[1] = true
            case .mapShops:
                showPOIType[2] = true
            case .mapParking:
                showPOIType[3] = true
            }
        }
        
        
        
        loadInitialData()
        
        for polyline in polyLineArray{
            mapView.addOverlay(polyline)
        }
        mapView.addAnnotations(pointsOfInterest)
        mapView.addAnnotations(drivingAnnotations)
    }
    
    @IBAction func showAnnotationDisclosure (_ sender: UIButton) {
        print("Disclosure button clicked")
        print(sender.tag)
        buttonChosen = sender.tag
        self .performSegue(withIdentifier: "AnnotationDetailsSegue", sender: nil)
    }
    
}

extension BikePathViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            if isEqual(type: MKPolyline.self, a: polyLineArray[0], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[1], b: overlay)! ||
                isEqual(type: MKPolyline.self, a: polyLineArray[2], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[3], b: overlay)! ||
                isEqual(type: MKPolyline.self, a: polyLineArray[4], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[5], b: overlay)!
            {
                lineView.strokeColor = UIColor.green
            }
            else if isEqual(type: MKPolyline.self, a: polyLineArray[6], b: overlay)! || isEqual(type: MKPolyline.self, a: polyLineArray[7], b: overlay)!{
                lineView.strokeColor = UIColor.blue
            }
            else {
                lineView.strokeColor = UIColor.purple
            }
            lineView.lineWidth = 5.0
            return lineView
        }
        
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //The one for information
        guard let annotation = annotation as? PointOfInterest else { return nil }
        
        //The one for directions
//        guard let annotation = annotation as? DrivingAnnotation else { return nil }
        
        //Need to change when using the default thing
        let identifier = MKMapViewDefaultAnnotationViewReuseIdentifier
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            
            let button = UIButton(type: .detailDisclosure)
            button.addTarget(self, action: #selector(showAnnotationDisclosure(_:)), for: .touchUpInside)
//            button.backgroundColor = UIColor.black
//            button.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
            button.tag = annotation.id
            
            view.leftCalloutAccessoryView = button
            
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let mapButton = UIButton(type: .detailDisclosure)
            mapButton.tag = -1
            view.rightCalloutAccessoryView = mapButton
            
            let button = UIButton(type: .detailDisclosure)
            button.addTarget(self, action: #selector(showAnnotationDisclosure(_:)), for: .touchUpInside)
//            button.backgroundColor = UIColor.black
//            button.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
            button.tag = annotation.id
            
            view.leftCalloutAccessoryView = button
        }
        return view
    }
    


    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! DrivingAnnotation
        if (control == view.rightCalloutAccessoryView){
            let location = view.annotation as! PointOfInterest
      //      let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            location.mapItem().openInMaps(launchOptions: launchOptions)
        }
    }
}

