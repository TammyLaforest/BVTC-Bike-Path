//
//  HowToPageViewController.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 12/6/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit

class HowToPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var subViewControllers:[UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToViewController1") as! HowToViewController1,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToViewController2") as! HowToViewController2,
			
			
				UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToViewController4") as! HowToViewController4,
			
			UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HowToViewController3") as! HowToViewController3
			
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex <= 0) {
            return nil
        }
        
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex >= subViewControllers.count-1) {
            return nil
        }
        
        return subViewControllers[currentIndex+1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    
    
    
    
    
   
    
    
    
}
