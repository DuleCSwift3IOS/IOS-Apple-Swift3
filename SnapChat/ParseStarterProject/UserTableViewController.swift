//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/23/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class UserTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var usernames = [String]()

    var recipientUsername = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"
        {
            PFUser.logOut()
            
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    func checkForMessages()
    {
        let query = PFQuery(className: "Image")
        
        query.whereKey("recipientUsername", equalTo: (PFUser.current()?.username)!)
        
        do
        {
            
            let images = try query.findObjects()
            
            if let pfObjects = images as? [PFObject]
            {
                for image in pfObjects
                {
                    var senderUsername = "Unknown User"
                    
                    if let username = image["senderUsername"] as? String
                    {
                        senderUsername = username
                    }
                    
                    if let pfFile = image["photo"] as? PFFile
                    {
                        pfFile.getDataInBackground(block: { (data, error) in
                            
                            if let imageData = data
                            {
                                image.deleteInBackground()
                                self.timer.invalidate()
                                
                                if let imageToDisplay = UIImage(data: imageData)
                                {
                                    let allertController = UIAlertController(title: "You have a message", message: "Message from" + senderUsername, preferredStyle: .alert)
                                    
                                    allertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                        
                                        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                        
                                        backgroundImageView.backgroundColor = UIColor.black
                                        
                                        backgroundImageView.alpha = 0.8
                                        
                                        backgroundImageView.tag = 10
                                        
                                        self.view.addSubview(backgroundImageView)
                                        
                                        let displayImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                        
                                        displayImageView.image = imageToDisplay
                                        
                                        displayImageView.tag = 10
                                        
                                        displayImageView.contentMode = UIViewContentMode.scaleAspectFill
                                        
                                        self.view.addSubview(displayImageView)
                                        
                                        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { (timer) in
                                            
                                            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(UserTableViewController.checkForMessages), userInfo: nil, repeats: true)
                                            
                                            for subview in self.view.subviews
                                            {
                                                if subview.tag == 10
                                                {
                                                    subview.removeFromSuperview()
                                                }
                                            }
                                            
                                        })
                                        
                                    }))
                                    
                                    self.present(allertController, animated: true, completion: nil)
                                }
                                
                            }
                            
                        })
                    }
                    
                    
                }
            }
            
        }
            
        catch
        {
            print("Could not get images")
        }

    }
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
         timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(UserTableViewController.checkForMessages), userInfo: nil, repeats: true)
        
        
        let query = PFUser.query()
        
        query?.whereKey("username", notEqualTo: (PFUser.current()?.username)!)
        
        do
        {
        let users = try query?.findObjects()
            
            if let users = users as? [PFUser]
            {
                for user in users
                {
                    self.usernames.append(user.username!)
                    
                    
                }
                
                tableView.reloadData()
                
            }
            
            
            
        }
        catch
        {
            print("Could not get a user!")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text  = self.usernames[indexPath.row]
        
        print(usernames[indexPath.row])

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        recipientUsername = usernames[indexPath.row]
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            print("Image returned")
            
            let imageToSend = PFObject(className: "Image")
            
            imageToSend["photo"] = PFFile(name: "photo.png", data: UIImagePNGRepresentation(image)!)
            
            imageToSend["senderUsername"] = PFUser.current()?.username
            
            imageToSend["recipientUsername"] = recipientUsername
            
            imageToSend.saveInBackground(block: { (success, error) in
                var title = "Sending Failed"
                var description = "Please try again leater"
                
                if success
                {
                    title = "Message Sent"
                    description = "Your message has been sent."
                }
                else
                {
                    
                }
                
                let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    
                }))
                self.present(alertController, animated: true, completion: nil)
            })
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
