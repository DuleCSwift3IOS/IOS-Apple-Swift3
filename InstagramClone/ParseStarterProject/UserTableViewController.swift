//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class UserTableViewController: UITableViewController {

    var usernames = [""]
    // Every user need this unique id for know which is that user
    var userIds = [""]
    
    var isFollowing = ["" : false]
    
    var refresher : UIRefreshControl!
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    override func viewDidAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
    }
    
    func refresh()
    {
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if error != nil
            {
                print(error!)
            }
            else if let users = objects
            {
                //here this is back the all removed usernames
                self.usernames.removeAll()
                //here this will back that all removed userIds
                self.userIds.removeAll()
                //And here we will back that all removed followers
                self.isFollowing.removeAll()
                for object in users
                {
                    if let user = object as? PFUser
                    {
                        //Here is code to show us the current loged user
                        if user.objectId != PFUser.current()?.objectId
                        {
                            let usernameArray = user.username!.components(separatedBy: "@")
                            self.usernames.append(usernameArray[0])
                            self.userIds.append(user.objectId!)
                            
                            let query = PFQuery(className: "Followers")
                            query.whereKey("follower", equalTo: (PFUser.current()?.objectId!)!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                if let objects = objects
                                {
                                    if objects.count > 0
                                    {
                                        self.isFollowing[user.objectId!] = true
                                    }
                                    else
                                    {
                                        self.isFollowing[user.objectId!] = false
                                    }
                                    //if number of followers is equal with numbers of users
                                    if self.isFollowing.count == self.usernames.count
                                    {
                                        self.tableView.reloadData()
                                        //here we add another code for stop refreshing
                                        self.refresher.endRefreshing()
                                    }
                                }
                            })
                        }
                        
                    }
                    
                }
                
            }
            //if this will be set here thay are will back an error because number of all dates from followers is not equal to numbers of all dates of users.Then we will set this pice of code up in query
            //self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        refresh()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(UserTableViewController.refresh), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
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
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]
        
        //if somebody is followed they are be checked
        if isFollowing[userIds[indexPath.row]]!
        {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
        
            if isFollowing[userIds[indexPath.row]]!
                {
                //here we will make to unfollowed users from table
                
                    isFollowing[userIds[indexPath.row]] = false
                    
                    cell?.accessoryType = UITableViewCellAccessoryType.none
                    
                    let query = PFQuery(className: "Followers")
                    query.whereKey("follower", equalTo: (PFUser.current()?.objectId!)!)
                    query.whereKey("following", equalTo: userIds[indexPath.row])
                    
                    query.findObjectsInBackground(block: { (objects, error) in
                        if let objects = objects
                        {
                            for object in objects
                            {
                                object.deleteInBackground()
                            }
                        }
                    })
                }
            else
                {
                    isFollowing[userIds[indexPath.row]] = true
                    
                    //here is a code which told to us that the other user is followed
                    cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        
                    let following = PFObject(className: "Followers")
        
                    following["follower"] = PFUser.current()?.objectId//which user follow other user
        
                    following["following"] = userIds[indexPath.row]//which is the id of followed  user
        
                    following.saveInBackground()
                }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
