//
//  ViewController.swift
//  Swipe Demo
//
//  Created by Dushko Cizaloski on 4/8/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Here we add programaticly added label on the view
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
        
        label.text = "Drag me!"
        
        label.textAlignment = NSTextAlignment.center
        
        view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecogizer: )))
        
        label.isUserInteractionEnabled = true
        
        label.addGestureRecognizer(gesture)
    }

    
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
            if label.center.x < 100
            {
                print("Not choosen")
            }
            else if label.center.x > self.view.bounds.width - 100
            {
                print("Choosen")
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            straechAndRotation = rotation.scaledBy(x: 1, y: 1)
            
            label.transform = straechAndRotation

            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
        
            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

