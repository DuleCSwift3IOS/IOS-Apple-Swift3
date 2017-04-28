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

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBAction func singupOrLogin(_ sender: Any) {
        
        if usernameField.text == ""
        {
            errorLabel.text = "A username is requier"
        }
        else
        {
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: "password", block: { (user, error) in
                
                if error != nil
                {
                    let user = PFUser()
                    user.username = self.usernameField.text
                    user.password = "password"
                    
                    user.signUpInBackground(block: { (success, error) in
                        if let error = error
                        {
                            var errorMessage = "Sing up Faield - Please try again later!"
                            
                            if let errorString = (error as NSError).userInfo["error"] as? String
                            {
                                errorMessage = errorString
                            }
                            
                            self.errorLabel.text = errorMessage
                        }
                        else
                        {
                            self.performSegue(withIdentifier: "showUserTable", sender: self)
                        }
                        
                    })
                }
                else
                {
                    print("User Logged In")
                    
                    self.performSegue(withIdentifier: "showUserTable", sender: self)
                }
                
                
            })
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil
        {
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
