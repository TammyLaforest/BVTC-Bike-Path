//
//  AnnotationDetailsViewController.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 4/23/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit

class AnnotationDetailsViewController: UIViewController {
    
    var annotationTitle : String = ""
    var selectedLocation = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleBackGroundImage: UIImageView!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let poi = pointsOfInterest[selectedLocation]
        titleLabel.text = poi.title
        var imageName = poi.title!.trimmingCharacters(in: .whitespacesAndNewlines) + ".jpg"
        if poi.title?.range(of: "Parking") != nil {
            imageName = "Parking.jpg"
        }
        titleBackGroundImage.layer.cornerRadius = 10
        titleBackGroundImage.alpha = 0.5
        titleBackGroundImage.backgroundColor = UIColor.gray
        imageView.image = UIImage.init(named: imageName)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        if poi.address.count > 1 {
            addressLabel.text = "Address: " + poi.address
        }
        else {
            addressLabel.text = "There is no address available"
        }
        
        if poi.phone.count > 1 {
            phoneLabel.text = "Phone Number: " + poi.phone
        }
        else {
            phoneLabel.text = "There is no phone number available"
        }
        
        if poi.hours.count > 1 {
            hoursLabel.text = "Hours: " + poi.hours
        }
        else {
            hoursLabel.text = "There are no hours available"
        }
        
        if poi.town.count > 1 {
            townLabel.text = "City/Town: " + poi.town
        }
        else {
            townLabel.text = "There is no city/town available"
        }
        
        if poi.website.count > 1 {
            websiteLabel.text = "Website: " + poi.website
            websiteLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickLabel))
            //let tapgesture = UITapGestureRecognizer.init(target: self, action:#selector(clickLabel(website:url!)))
            tap.numberOfTapsRequired = 1
            websiteLabel.addGestureRecognizer(tap)
        }
        else {
            websiteLabel.text = "There is no website available"
        }
        
    }
    
    @objc func clickLabel() {
        let poi = pointsOfInterest[selectedLocation]
        let url = URL(string: poi.website)
        UIApplication.shared.open(url!)
    }
        
}
