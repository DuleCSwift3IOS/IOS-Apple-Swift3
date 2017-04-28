//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Dushko Cizaloski on 2/14/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
      var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake
        {
            let soundArray = ["bow","flexitone","light", "shoot","wolfwhistle"]
            
            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count)))
            
            let musicPath = Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3")
            
            do
            {
                
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicPath!))
                player.play()
            }
            catch
            {
                //Process do any errors
                
                
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

