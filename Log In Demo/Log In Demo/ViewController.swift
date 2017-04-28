//
//  ViewController.swift
//  Log In Demo
//
//  Created by Dushko Cizaloski on 2/15/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet var textFiled: UITextField!
    @IBOutlet var label: UILabel!
    
    @IBOutlet var LogOutButton: UIButton!
    
    var isLoggedIn = false
    @IBAction func LogOut(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do
        {
            
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for result in results  as! [NSManagedObject]
                {
                    context.delete(result)
                    
                    do
                    {
                        try context.save()
                    }
                    catch
                    {
                        print("Individual delete failed")
                    }
                }
                
                label.alpha = 0
                
                LogOutButton.alpha = 0
                
                
                LogInButton.setTitle("LogIn", for: [])
                
                isLoggedIn = false
                
                textFiled.alpha = 1
            }
            
        }
        catch
        {
            print("Delete Failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject]
            {
                if let username = result.value(forKey: "name") as? String
                {
                    textFiled.alpha = 0
                    LogInButton.setTitle("Update Username", for: [])
                    label.alpha = 1
                    label.text = "Hi There " +  username + "!"
                    LogOutButton.alpha = 1
                }
            }
        }
        catch
        {
            print("Request Failed")
        }
    }
    @IBOutlet var LogInButton: UIButton!
    @IBAction func LogIn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let context = appDelegate?.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context!)
        
        if isLoggedIn
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            
            do
            {
                let results =  try context?.fetch(request)
                
                if (results?.count)! > 0
                {
                    for result in results as! [NSManagedObject]
                    {
                        result.setValue(textFiled.text, forKey: "name")
                        
                        do
                        {
                          try  context?.save()
                        }
                        catch
                        {
                            print("Update username save Failed")
                        }
                    }
                    
                    label.text = "Hi there " + textFiled.text! + "!"
                    
                }
                
            }
            catch
            {
                print("Update username Failed")
            }
            
        }
        else
        {
            newValue.setValue(textFiled.text, forKey: "name")
        
            do
            {
                try context?.save()
            
           
                LogInButton.setTitle("Update username", for: [])
                label.alpha = 1
                label.text = "Hi There " +  textFiled.text! + "!"
            
                isLoggedIn = true
                
                LogOutButton.alpha = 1
            }
            catch
            {
                print("Faild to save")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

