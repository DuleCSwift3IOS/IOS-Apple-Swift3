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

    var singUpMode = true
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var SingUpOrLoginButton: UIButton!
    
    @IBAction func SingUpOrLogin(_ sender: Any) {
        //third step is user make to login on the site
        if singUpMode
        {
        //Secound step  is making user sing up
        let user = PFUser()
        
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
            //Here this code is for allowed to current user to access or write something to other user
            
        let acl = PFACL()
            acl.getPublicReadAccess = true
            acl.getPublicReadAccess = true
            
            user.acl = acl
            
        user.signUpInBackground { (success, error) in
            if error != nil
            {
                var errorMessage = "Sing Up failed - Pleas try again"
                
                if let parseError = (error as! NSError).userInfo["error"] as? String
                {
                    errorMessage = parseError
                }
                
                self.errorLabel.text = errorMessage
            }
            else
            {
                print("Singed Up")
                self.performSegue(withIdentifier: "goToUserInfo", sender: self)
            }
            //ended here
        }
        
      }
        else
        {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                //here we used same code for singUp action
                if error != nil
                {
                    var errorMessage = "Sing Up failed - Pleas try again"
                    
                    if let parseError = (error as! NSError).userInfo["error"] as? String
                    {
                        errorMessage = parseError
                    }
                    
                    self.errorLabel.text = errorMessage
                }
                else
                {
                    print("Logged In")
                    self.redirectUser()
                }
                
            })
        }
        
    }
    @IBOutlet var changeSingUpModeButton: UIButton!
    @IBAction func changeSingUpMode(_ sender: Any) {
        
        //This is a first step for make a login form functionality
        if singUpMode
        {
            singUpMode = false
            
            SingUpOrLoginButton.setTitle("Log In", for: [])
            
            changeSingUpModeButton.setTitle("Sing Up", for: [])
        
        }
        else
        {
            singUpMode = true
            
            SingUpOrLoginButton.setTitle("Sing Up", for: [])
            
            changeSingUpModeButton.setTitle("Log In", for: [])
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       redirectUser()
    }
    
    func redirectUser()
    {
        if PFUser.current() != nil
        {
            if PFUser.current()?["isFemale"] != nil && PFUser.current()?["isInterestedInWomen"] != nil && PFUser.current()?["photo"] != nil
            {
                performSegue(withIdentifier: "swipeFromInitialSegue", sender: self)
            }
            else
            {
                performSegue(withIdentifier: "goToUserInfo", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     /*
        let testObject = PFObject(className: "TestObject3")
        
        testObject["foo"] = "bar"
        
        testObject.saveInBackground { (success, error) -> Void in
            
            // added test for success 11th July 2016
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error!)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
