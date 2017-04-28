//
//  ViewController.swift
//  Spinners & Alerts
//
//  Created by Dushko Cizaloski on 3/18/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var activityIndicator = UIActivityIndicatorView()
    
    @IBAction func restoreApp(_ sender: Any) {
        
        activityIndicator.stopAnimating()
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    @IBAction func pauseApp(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    @IBAction func createAlert(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Hey There!", message: "Are you shure?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("Ok button pressed")
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) in
            print("No button pressed")
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

