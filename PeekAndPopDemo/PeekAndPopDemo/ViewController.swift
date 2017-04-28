//
//  ViewController.swift
//  PeekAndPopDemo
//
//  Created by Dushko Cizaloski on 4/21/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available
        {
            registerForPreviewing(with: self, sourceView: view)
        }
        else
        {
            print("Force Touch is not Available")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIViewControllerPreviewingDelegate
{
    //Method for Peek
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let peekViewController = storyboard?.instantiateViewController(withIdentifier: "peekViewController")
        
        return peekViewController
        
    }
    //Method for Pop
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
            let popViewController = storyboard?.instantiateViewController(withIdentifier: "popViewController")
        
          show(popViewController!, sender: self)
    }
    
}
