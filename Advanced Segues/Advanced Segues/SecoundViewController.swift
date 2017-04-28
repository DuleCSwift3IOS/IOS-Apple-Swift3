//
//  SecoundViewController.swift
//  Advanced Segues
//
//  Created by Dushko Cizaloski on 2/12/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class SecoundViewController : UIViewController
{
    var username = "dushko"
    
    var activeRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(globalVariable)
        print(activeRow)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
