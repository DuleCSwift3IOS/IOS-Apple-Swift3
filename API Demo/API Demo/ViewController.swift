//
//  ViewController.swift
//  API Demo
//
//  Created by Dushko Cizaloski on 3/11/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var reslutLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBAction func submitAction(_ sender: Any) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=13c8ca5b85575411ff3814db2c654fee")
        {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                print(error)
            }
            else
            {
                if let urlContent = data
                {
                    do {
                        let jsonResults = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResults)
//                        print(jsonResults["name"])
                        
                        if let descrtiption = ((jsonResults["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String
                        {
                            DispatchQueue.main.sync(execute: {
                                
                                self.reslutLabel.text = descrtiption
                                
                            })
                        }
                        
                    }
                        
                    catch
                    {
                        print("JSON Processing Faild")
                    }
                }
            }
        }
        
        task.resume()
        }
        else
        {
            reslutLabel.text = "Could't be found weather for that city, pleas try anonther"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

