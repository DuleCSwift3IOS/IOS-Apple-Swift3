//
//  ViewController.swift
//  Media Player
//
//  Created by Dushko Cizaloski on 2/14/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
var timer = Timer()
let audioPath = Bundle.main.path(forResource: "sheep", ofType: "mp3")
   func updateScrubber()
   {
    scrubber.value = Float(player.currentTime)
   }
    @IBAction func playButton(_ sender: Any) {
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        player.pause()
        
        timer.invalidate()
    }
    
    @IBAction func movedSlider(_ sender: Any) {
        player.volume = slider.value
    }
    
    @IBOutlet var slider: UISlider!
    var player = AVAudioPlayer()
    @IBAction func scrubberSlider(_ sender: Any) {
        
        player.currentTime = TimeInterval(scrubber.value)
        
    }
    
    @IBAction func stopButton(_ sender: Any) {
        
        timer.invalidate()
        
        player.pause()
        
        do
        {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
           
        }
        catch
        {
            //Process do any errors
            
            
        }
        
    }
    
    @IBOutlet var scrubber: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        do
        {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubber.maximumValue = Float(player.duration)
            
        }
        catch
        {
            //Process do any errors
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

