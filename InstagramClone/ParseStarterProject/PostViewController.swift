//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageToPost: UIImageView!
    
    var activityIndicator = UIActivityIndicatorView()
    
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //This is action for get image from libary and set to the user
    @IBAction func chooseAnImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    //this will choose image from libery and then will be set to the place of imageToPost
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                    imageToPost.image = image
            }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var messageTextField: UITextField!
    @IBAction func postImage(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //This class it's uses for set all image which will be used for our users
        let post = PFObject(className: "Posts")
        
        post["message"] = messageTextField.text
        
        post["userid"] = PFUser.current()?.objectId
        
        let imageData = UIImagePNGRepresentation(imageToPost.image!)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        //If we will like to make a customise our image or text field we make that after other code
        post.saveInBackground { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if error != nil
            {
                self.createAlert(title: "Could not post an image", message: "Please try again leater.")
            }
            else
            {
                self.createAlert(title: "Image Posted!", message: "Your image has been posted succesfully")
                
                self.messageTextField.text = ""
                
                self.imageToPost.image = UIImage(named: "Person_icon.png")
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
