//
//  HomeScreenViewController.swift
//  Cycle Blackstone
//
//  Created by Christian Laiter on 3/3/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bikeVar = BikePathViewController()
        if !initialDataLoaded{
            bikeVar.loadInitialData()
            pointsOfInterest = pointsOfInterest.sorted{$0.title! < $1.title!}
        }
//        logoImage.layer.masksToBounds = true
//        logoImage.layer.cornerRadius = 45.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

