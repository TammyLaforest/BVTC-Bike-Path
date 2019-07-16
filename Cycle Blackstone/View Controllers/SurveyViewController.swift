//
//  SurveyViewController.swift
//  CycleBlackstone
//
//  Created by Christian Laiter on 9/16/18.
//  Copyright © 2018 Christian Laiter. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var ZipCodeTextField: UITextField!
    
    @IBOutlet weak var SightseeingToggle: UIButton!
    
    @IBOutlet weak var TransportationToggle: UIButton!
    
    @IBOutlet weak var ExerciseToggle: UIButton!
    
    @IBOutlet weak var SkipButton: UIButton!
    
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBOutlet weak var ZipCodeWarningLabel: UILabel!
    
    @IBOutlet weak var backgroundButton1: UIButton!
    @IBOutlet weak var backgroundButton2: UIButton!
    @IBOutlet weak var backgroundButton3: UIButton!
    
    
    
    let confirmColor = UIColor.black
    let unconfirmColor = UIColor.white
    let cornerRadius:CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ZipCodeTextField.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view, typically from a nib.
        
        ZipCodeWarningLabel.isHidden = true
        self.hideKeyboardWhenTappedAround()
        
        SubmitButton.layer.cornerRadius = 10.0
        
        SightseeingToggle.backgroundColor = unconfirmColor
        TransportationToggle.backgroundColor = unconfirmColor
        ExerciseToggle.backgroundColor = unconfirmColor
        
        backgroundButton1.backgroundColor = unconfirmColor
        backgroundButton2.backgroundColor = unconfirmColor
        backgroundButton3.backgroundColor = unconfirmColor
        backgroundButton3.backgroundColor = unconfirmColor
        
        backgroundButton1.layer.cornerRadius = cornerRadius
        backgroundButton2.layer.cornerRadius = cornerRadius
        backgroundButton3.layer.cornerRadius = cornerRadius
        backgroundButton3.layer.cornerRadius = cornerRadius
        
        SightseeingToggle.layer.cornerRadius = 0.5 * SightseeingToggle.bounds.size.width
        TransportationToggle.layer.cornerRadius = 0.5 * TransportationToggle.bounds.size.width
        ExerciseToggle.layer.cornerRadius = 0.5 * ExerciseToggle.bounds.size.width
    }
    
    
    
    @IBAction func submitButtonPressed (_ sender: UIButton) {
      
        let zipcode:String = ZipCodeTextField.text!
        
        if zipcode.count == 5 {
            ZipCodeWarningLabel.isHidden = true
            
            if SightseeingToggle.backgroundColor == confirmColor {
                print("They want to eat things")
            }
            if TransportationToggle.backgroundColor == confirmColor {
                print("They want to shop")
            }
            if ExerciseToggle.backgroundColor == confirmColor {
                print("They want to ride")
            }
            
            self .performSegue(withIdentifier: "SurveySegue", sender: nil)
        }
        else {
            ZipCodeWarningLabel.isHidden = false
        }
        
        
        
    }
    
    @IBAction func skipButtonPressed (_ sender: UIButton) {
        self .performSegue(withIdentifier: "SurveySegue", sender: nil)
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
    
    @IBAction func toggleButtonColor (_ sender: UIButton) {
        if sender.backgroundColor == unconfirmColor {
            sender.backgroundColor = confirmColor
        }
        else
        {
            sender.backgroundColor = unconfirmColor
        }
        
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
