//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by Dushko Cizaloski on 4/21/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    @IBOutlet var resultsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let authenticationContext = LAContext()
        
        var error: NSError?
        
       if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error )
       {
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We like to know who you are...") { (success, error) in
            if success
            {
                self.resultsLabel.text = "User has autheticated"
            }
            else
            {
                if let error = error
                {
                    print(error)
                    
                    self.resultsLabel.text = "Error"
                }
                else
                {
                    print("Did not authenticate")
                }
            }
        }
    
    }
        else
       {
            self.resultsLabel.text = "Device does not have touch ID"
       }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

