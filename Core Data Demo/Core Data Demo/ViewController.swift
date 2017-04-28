//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Dushko Cizaloski on 2/15/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
       /*
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("Dukica", forKey: "username")
        newUser.setValue("duki1234", forKey: "password")
        newUser.setValue(2, forKey: "age")
        
        do
        {
            
            try context.save()
            print("Saved")
        }
        catch
        {
            print("We have some error here!")
        }
        */
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
       // request.predicate = NSPredicate.init(format: "username = %@", "Kopile")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
          let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let username = result.value(forKey: "username") as? String
                    {
                      /*  context.delete(result)
                        
                        do
                        {
                            try context.save()
                            
                        }
                        catch
                        {
                            print("Delete Faild")
                        }
                        result.setValue("Kopile", forKey: "username")
                        
                        do
                        {
                            try context.save()
                            
                        }
                        catch
                        {
                            print("Renamed Faild")
                        }*/
                        
                        print(username)
                    }
                    
                }
            }
            else
            {
                print("No results")
            }
        }
        catch
        {
            print("Could't catch results")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

