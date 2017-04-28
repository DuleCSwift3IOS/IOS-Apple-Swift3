//
//  SwipingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/9/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class SwipingViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var displayedUserID = ""
    
    func wasDragged(gestureRecogizer: UIPanGestureRecognizer)
    {
        let translation = gestureRecogizer.translation(in: view)
        
        let label = gestureRecogizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 100)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var straechAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = straechAndRotation
        
        if gestureRecogizer.state == UIGestureRecognizerState.ended
        {
            var acceptedOrRejected = ""
            
            if label.center.x < 100
            {
                acceptedOrRejected = "rejected"
            }
            else if label.center.x > self.view.bounds.width - 100
            {
                acceptedOrRejected = "accepted"
                //Here we added a code where we must to set a images from the server for other femile users
                updateImage()
            }
            
            if acceptedOrRejected != nil && displayedUserID != nil
            {
                //Here with this code we will make parsing on userid. And if the user swipe left thay are rejected or user swipe right thay are accepted
                
                PFUser.current()?.addUniqueObjects(from: [displayedUserID], forKey: acceptedOrRejected)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    
                    //Here we added a code where we must to set a images from the server for other femile users
                    
                    self.updateImage()
                })
                
                
                
                //Here we like on the column accepted and rejected to add the current userIds from all users which is rejected and accepted
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            straechAndRotation = rotation.scaledBy(x: 1, y: 1)
            
            label.transform = straechAndRotation
            
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
    }
    
    func updateImage()
    {
        
        // Here is code which make us to update image from parse server get them from there and past to the current user
        //That photos it's for a persons which likes mans and that is a womens
        
        let query = PFUser.query()
        
        query?.whereKey("isFemale", equalTo: (PFUser.current()?["isInterestedInWomen"])!)
        
        query?.whereKey("isInterestedInWomen", equalTo: (PFUser.current()?["isFemale"])!)
        
        var ignoredUsers = [""]
        
        if let acceptedUser = PFUser.current()?["accepted"]
        {
            ignoredUsers += acceptedUser as! Array
        }
        
        if let rejectedUsers = PFUser.current()?["rejected"]
        {
            ignoredUsers += rejectedUsers as! Array
        }
        
        query?.whereKey("objectId", notContainedIn: ignoredUsers)
        
        //here we added a code which will looked a near by users
        
        if let latitude = (PFUser.current()?["location"] as AnyObject).latitude
        {
            if let longitude = (PFUser.current()?["location"] as AnyObject).longitude
            {
                query?.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 1, longitude: longitude - 1), toNortheast: PFGeoPoint(latitude: latitude + 1, longitude: longitude + 1))
            }
        }
        
        query?.limit = 1
        
        query?.findObjectsInBackground(block: { (objects, error) in
            if let users = objects
            {
                for object in users
                {
                    if let user = object as? PFUser
                    {
                        //here we make to access to the current usersids
                        self.displayedUserID = user.objectId!
                        let imageFile = user["photo"] as? PFFile
                        
                        imageFile?.getDataInBackground(block: { (data, error) in
                            if let imageData = data
                            {
                                self.imageView.image = UIImage(data: imageData)
                            }
                        })
                    }
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecogizer: )))
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(gesture)
        
        //This is for location where is the current user actualy that is me
        PFGeoPoint.geoPointForCurrentLocation { (geopoint, error) in
            
            if let geopoint = geopoint
            {
                PFUser.current()?["location"] = geopoint
                
                PFUser.current()?.saveInBackground()
            }
            
        }
        
        updateImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"
        {
            PFUser.logOut()
        }
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
