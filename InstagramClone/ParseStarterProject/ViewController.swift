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

    var SingUpMode = true
    
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var SingUpOrLogin: UIButton!
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func SingUpOrLogin(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == ""
        {
            createAlert(title: "Error in form", message: "Pleas enter an email or password?")
            
        }
        else
        {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if SingUpMode
            {
                // Sing Up
                
                let user = PFUser()
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
               
                
                user.signUpInBackground(block: { (success, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil
                    {
                        var DisplayErrorMessage = "Please try again leater."
                        
                        
                        if let errorMessage = (error as! NSError).userInfo["error"] as? String
                        {
                            DisplayErrorMessage = errorMessage
                        }
                        self.createAlert(title: "SingUp Error", message: DisplayErrorMessage)
                    }
                    else
                    {
                        print("user sing up")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            }
            else
            {
                //login Mode
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error != nil
                    {
                        var DisplayErrorMessage = "Please try again leater."
                        
                        
                        if let errorMessage = (error as! NSError).userInfo["error"] as? String
                        {
                            DisplayErrorMessage = errorMessage
                        }
                        self.createAlert(title: "Login Error", message: DisplayErrorMessage)
                    }
                    else
                    {
                        print("Logged In")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                    
                })
            }
        }
    }
    
    @IBOutlet var changeSingUpModeButton: UIButton!
    
    @IBOutlet var messageLabel: UILabel!
    
   
    @IBAction func changeSingUpMode(_ sender: Any) {
        
                if SingUpMode
                {
                    // Change to Login Mode
        
                    SingUpOrLogin.setTitle("Log In", for: [])
        
                    changeSingUpModeButton.setTitle("Sing Up", for: [])
        
                    messageLabel.text = "Don't have an account?"
        
                    SingUpMode = false
                }
                else
                {
        
                    SingUpOrLogin.setTitle("Sing Up", for: [])
        
                    changeSingUpModeButton.setTitle("Log In", for: [])
                    
                    messageLabel.text = "Already have an account?"
        
                    SingUpMode = true
                    
                }
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil
        {
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
        self.navigationController?.navigationBar.isHidden = true
    }

    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
/*
        let userName = PFObject(className: "Users")
        
        userName["username"] = "Dushko"
        
        userName.saveInBackground { (success, error) -> Void in
            
            // added test for success 11th July 2016
            // added test for success 19th March 2017
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
 */
        
//        let query = PFQuery(className: "Users")
//        
//        query.getObjectInBackground(withId: "pDIAdpipyj") { (object, error) in
//            
//            if error != nil
//            {
//                print("Error")
//            }
//            else
//            {
//                if let userName = object
//                {
//                    userName["username"] = "Dushko"
//                    
//                    userName.saveInBackground(block: { (success, error) in
//                       if  success
//                       {
//                            print("Saveing")
//                       }
//                        else
//                       {
//                          print("Error")
//                       }
//                        
//                    })
//                    
//                }
//            }
//            
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
