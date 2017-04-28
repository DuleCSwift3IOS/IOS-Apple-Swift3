//
//  ViewController.swift
//  Downloading Images From the Web
//
//  Created by Dushko Cizaloski on 2/16/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //And here we get the saved datas localy from disk and read them from there
        
        let documnetsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documnetsPath.count > 0
        {
            let documentsDirectory = documnetsPath[0]
            
            let restorePath =  documentsDirectory + "/bach.jpg"
            
            imageview.image = UIImage(contentsOfFile: restorePath)
        }
        
        
        
        
       /*
         The first code is for download image with using a URL go to them and save the data from them
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")
        
        
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            data , response, error in
            
            if error != nil
            {
                print(error as Any)
            }
            else
            {
                if let data = data
                {
                    
                    if let bachImage = UIImage(data: data)
                    {
                        self.imageview.image = bachImage
                        Here this code is for saved the downloaded datas from server and they be stored localy
                        let documnetsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        
                        if documnetsPath.count > 0
                        {
                            let documentsDirectory = documnetsPath[0]
                            
                            let savePath =  documentsDirectory + "/bach.jpg"
                            
                            do
                            {
                                try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath))
                            }
                            catch
                            {
                                //Process Error
                            }
                        }
                    }
                    
                }
            }
        }
        task.resume()
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

