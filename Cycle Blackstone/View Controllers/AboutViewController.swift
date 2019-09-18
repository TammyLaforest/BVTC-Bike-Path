//
//  AboutViewController.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 9/18/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var secondaryLabel: UILabel!
    @IBOutlet var feedbackLabel: UILabel!
    @IBOutlet var aboutImage: UIImageView!
    
    @IBOutlet var aboutTextView: UITextView!
    @IBOutlet var secondaryTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        scrollView.contentSize = CGSize.init(width: 375, height: 750)
        aboutImage.layer.bounds = CGRect.init(x: 0, y: 0, width: 375, height: 191)
        aboutLabel = UILabel.init(frame: CGRect(x: 0, y: 225, width: 375, height: 35))
        aboutLabel.textAlignment = NSTextAlignment.center
        aboutTextView = UITextView.init(frame: CGRect(x: 0, y: 260, width: 375, height: 400))
        secondaryLabel = UILabel.init( frame: CGRect(x: 0, y: 490, width: 375, height: 70))
        secondaryLabel.textAlignment = NSTextAlignment.center
        secondaryTextView = UITextView.init(frame: CGRect(x: 0, y: 550, width: 375, height: 400))
        feedbackLabel = UILabel.init(frame: CGRect.init(x: 0, y: 1000, width: 375, height: 100))
		
        scrollView.addSubview(aboutLabel)
        scrollView.addSubview(aboutTextView)
        scrollView.addSubview(secondaryLabel)
        scrollView.addSubview(secondaryTextView)
        scrollView.addSubview(feedbackLabel)
        scrollView.addSubview(aboutImage)
		
        aboutLabel.text = "About Us"
        aboutTextView.text = "\tThis application was designed by the Blackstone Valley Tourism Council to enhance your visit while you enjoy the Blackstone River Bikeway. \n\n\tThis Bikeway is a combination of off-road and on-road cycling enjoyment, offering a beautiful 12 mile off-road portion through Cumberland, Lincoln, and Woonsocket. It is a premium bikeway in Rhode Island. \n\n\t Extending your enjoyment on-road adds several more miles to India Point in Providence and then to Bristol to the south with another 18 miles off-road cycling. Travel to the north into Massachusetts where more off-road cycling awaits. The Blackstone River Bikeway is clearly marked with signs./n Visitors can easily get on or off at multiple locations along the route, accommodating any distance or areas visitors wish to experience."
        
        secondaryLabel.text = "Blackstone River Bikeway Bike Stops"
        secondaryTextView.text = "\tVisitors pass many unique experiences to enjoy. The Tourism Council has identified many 'Bike Stops' along the bikeway that will welcome you. The Blackstone River Bikeway can be used for recreation, sightseeing or exercise. It is a fun way to go to the library or city hall, shop at some unique stores, view the natural beauty of the river, and stop and taste the many delicious cultural foods the Valley has to offer.\n\t We are excited about our special area along the Blackstone River and hope you will stop and explore while you are on the bikeway."
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

