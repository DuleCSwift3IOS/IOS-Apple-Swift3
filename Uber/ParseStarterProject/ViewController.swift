/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    func displayAlert(title: String, message: String)
    {
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }
    
    var singUpMode = true
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var isDriverSwitch: UISwitch!
    @IBAction func singupOrLogin(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == ""
        {
            displayAlert(title: "Error in form", message: "Username and password are required")
        }
        else
        {
            
            if singUpMode
            {
                
                let user = PFUser()
                
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user["isDriver"] = isDriverSwitch.isOn
                
                user.signUpInBackground(block: { (success, error) in
                    if let error = error
                    {
                        var displayErrorMessage = "Please try again leater"
                        
                        if let parseError = (error as! NSError).userInfo["error"] as? String
                        {
                            
                            displayErrorMessage = parseError
                            
                        }
                        
                        self.displayAlert(title: "Sing Up Failed", message: displayErrorMessage)
                        
                    }
                    else
                    {
                        
                        print("Sing Up Successful")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool
                        {
                            if isDriver
                            {
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                            }
                            else
                            {
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                            }
                        }
                        
                    }
                })
                
            }
            else
            {
                
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    if let error = error
                    {
                        var displayErrorMessage = "Please try again leater"
                        
                        if let parseError = (error as! NSError).userInfo["error"] as? String
                        {
                            
                            displayErrorMessage = parseError
                            
                        }
                        
                        self.displayAlert(title: "Sing Up Failed", message: displayErrorMessage)
                        
                    }
                    else
                    {
                        
                        print("Log In Successful")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool
                        {
                            if isDriver
                            {
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                            }
                            else
                            {
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                            }
                        }
                        
                    }
                    
                })
                
            }
            
        }
    }
    @IBOutlet var driverLabel: UILabel!
    @IBOutlet var riderLabel: UILabel!
    @IBOutlet var singupOrLogin: UIButton!
    @IBOutlet var singupSwitchButton: UIButton!
    @IBAction func switchSingupMode(_ sender: Any) {
        
        if singUpMode
        {
            singupOrLogin.setTitle("Log In", for: [])
            
            singupSwitchButton.setTitle("Switch To Sing Up", for: [])
            
            singUpMode = false
            
            isDriverSwitch.isHidden = true
            
            driverLabel.isHidden = true
            
            riderLabel.isHidden = true
            
        }
        else
        {
            singupOrLogin.setTitle("Sing Up", for: [])
            
            singupSwitchButton.setTitle("Switch To Log In", for: [])
            
            singUpMode = true
            
            isDriverSwitch.isHidden = false
            
            driverLabel.isHidden = false
            
            riderLabel.isHidden = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let isDriver = PFUser.current()?["isDriver"] as? Bool
        {
            if isDriver
            {
                performSegue(withIdentifier: "showDriverViewController", sender: self)
            }
            else
            {
                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
