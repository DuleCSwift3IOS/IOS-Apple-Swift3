//
//  UserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/9/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse


class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBAction func updateProfileImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
       {
        userImage.image = image
       }
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var genderSwitch: UISwitch!
    @IBOutlet var interestedSwitch: UISwitch!
    @IBAction func uodate(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = genderSwitch.isOn
        
        PFUser.current()?["isInterestedInWomen"] = interestedSwitch.isOn
        
        let imageDate = UIImagePNGRepresentation(userImage.image!)
        
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageDate!)
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            
            if error != nil
            {
                var errorMessage = "Update failed - Pleas try again"
                
                if let parseError = (error as! NSError).userInfo["error"] as? String
                {
                    errorMessage = parseError
                }
                
                self.errorLabel.text = errorMessage
            }
            else
            {
                print("Updated")
                self.performSegue(withIdentifier: "showSwipingViewController", sender: self)
            }
            
        })
        
        print(genderSwitch.isOn)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let isFemail = PFUser.current()?["isFemale"] as? Bool
        {
            genderSwitch.setOn(isFemail, animated: false)
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool
        {
            interestedSwitch.setOn(isInterestedInWomen, animated: true)
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile
        {
            photo.getDataInBackground(block: { (data, error) in
                
                if let imageDate = data
                {
                    if let downloadedImage = UIImage(data: imageDate)
                    {
                        self.userImage.image = downloadedImage
                    }
                }
            })
        }
        
        var counter = 0
        
        let urlArray = ["https://s-media-cache-ak0.pinimg.com/564x/9c/5e/86/9c5e86be6bf91c9dea7bac0ab473baa4.jpg","http://www.clipartbest.com/cliparts/jix/aae/jixaaeBxT.jpg","http://static.makers.com/styles/mobile_gallery/s3/betty-boop-cartoon-576km071213_0.jpg?itok=9qNg6GUd","http://img1.rnkr-static.com/user_node_img/65/1285832/C250/jessica-rabbit-film-characters-photo-u6.jpg","https://s-media-cache-ak0.pinimg.com/236x/f1/4a/66/f14a66e641f2a73409f54b7da3a8fb36.jpg","http://orig08.deviantart.net/3f8c/f/2014/357/4/f/my_south_park_female_character_by_drizz67-d8axss1.jpg"]
        
        
        for urlString in urlArray
        {
            counter += 1
            let url = URL(string: urlString)!
            do
            {
                let data = try Data(contentsOf: url)
                
                let imageFile = PFFile(name: "photo.png", data: data)
                
                let user = PFUser()
                
                user["photo"] = imageFile
                
                user.username = String(counter)
                
                user.password = "password"
                
                user["isInterestedInWomen"] = false
                
                user["isFemale"] = true
                
                let acl = PFACL()
                
                acl.getPublicReadAccess = true
                
                user.acl = acl
                
                user.signUpInBackground(block: { (success, error) in
                    if success
                    {
                        print("user singed up")
                    }
                })
                
            }
            catch
            {
                print("Could not get data")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
