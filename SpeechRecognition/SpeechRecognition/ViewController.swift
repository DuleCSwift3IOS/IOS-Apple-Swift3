//
//  ViewController.swift
//  SpeechRecognition
//
//  Created by Dushko Cizaloski on 4/22/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Speech


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let audioPath = Bundle.main.path(forResource: "test", ofType: "webarchive")
        {
         let url = URL(fileURLWithPath: audioPath)
            
            let recognizer = SFSpeechRecognizer()
            
            let request = SFSpeechURLRecognitionRequest(url: url)
            
            recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                if result != nil
                {
                    print(result?.bestTranscription.formattedString)
                }
                else
                {
                    print(result)
                }
            })
        }
        else
        {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

