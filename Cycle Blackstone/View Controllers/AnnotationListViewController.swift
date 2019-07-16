//
//  AnnotationListViewController.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 6/10/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit


class AnnotationListViewController: UIViewController {
    
//    var selectedOptions = [MapOptionsType]()
    
    var cellChosen = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnnotationDetailsFromListSegue"{
            (segue.destination as? AnnotationDetailsViewController)?.selectedLocation = cellChosen
        }
        
    }
}

// MARK: - UITableViewDataSource
extension AnnotationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointsOfInterest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnotationCell")!
        
        cell.textLabel?.text = pointsOfInterest[indexPath.row].title
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AnnotationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellChosen = indexPath.row
        performSegue(withIdentifier: "AnnotationDetailsFromListSegue", sender: nil)
    }
}
