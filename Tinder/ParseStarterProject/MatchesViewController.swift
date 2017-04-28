//
//  MatchesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/10/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    var images = [UIImage]()
    
    var userIds = [String]()
    
    var messages = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let query = PFUser.query()
        
        query?.whereKey("accepted", contains: PFUser.current()?.objectId)
        
        query?.whereKey("objectId", containedIn: PFUser.current()?["accepted"] as! [String])
        
        query?.findObjectsInBackground(block: { (objects, error) in
            if let users = objects
            {
                for object in users
                {
                    if let user = object as? PFUser
                    {
                        let imageFile = user["photo"] as! PFFile
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            if let imageData = data
                            {
                                let messageQuery = PFQuery(className: "Message")
                                
                                messageQuery.whereKey("recipient", equalTo: (PFUser.current()?.objectId)!)
                                
                                messageQuery.whereKey("sender", equalTo: user.objectId!)
                                
                                messageQuery.findObjectsInBackground(block: { (objects, error) in
                                    
                                   var messageText = "No Message from this user"
                                    
                                    if let objects = objects
                                    {
                                        for object in objects
                                        {
                                            if let message = object as? PFObject
                                            {
                                                if let messageContent = message["content"] as? String
                                                {
                                                    messageText = messageContent
                                                }
                                            }
                                        }
                                    }
                                    
                                    self.messages.append(messageText)
                                    
                                    self.images.append(UIImage(data: imageData)!)
                                    
                                    self.userIds.append(user.objectId!)
                                    
                                    self.tableView.reloadData()
                                    
                                })
                            }
                            
                        })
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MatchesCell") as! MatchesTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesCell", for: indexPath) as! MatchesTableViewCell
        
        cell.userImageView.image = images[indexPath.row]
        
        cell.messagesLabel.text = "You haven't received a message yet"
        
        cell.userIdLabel.text = userIds[indexPath.row]
        
        cell.messagesLabel.text = messages[indexPath.row]
        
        return cell
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
