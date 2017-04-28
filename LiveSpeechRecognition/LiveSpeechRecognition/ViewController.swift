//
//  ViewController.swift
//  LiveSpeechRecognition
//
//  Created by Dushko Cizaloski on 4/22/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Speech
class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet var textView: UITextView!
    @IBOutlet var recordingButton: UIButton!
    
    let speechRecognizer = SFSpeechRecognizer()!
    
    let audioEngine = AVAudioEngine()
    
    var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    var recognitionTask = SFSpeechRecognitionTask()
    
    @IBAction func recordingButtonTapped(_ sender: Any) {
        
        if audioEngine.isRunning
        {
            audioEngine.stop()
            
            recognitionRequest.endAudio()
            
            recognitionTask.cancel()
            
            recordingButton.setTitle("Start Recodring", for: [])
        }
        else
        {
            recordingButton.setTitle("Stop Recording", for: [])
        do
        {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
            
            
            
           if let inputNode = audioEngine.inputNode
           {
                recognitionRequest.shouldReportPartialResults = true
            
           recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                
                if let result = result
                {
                    self.textView.text = result.bestTranscription.formattedString
                    
                    if result.isFinal
                    {
                        self.audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        
                        self.recordingButton.setTitle("Start Recodring", for: [])
                    }
                    
                }
                
            })
            
            let recognitionFormat = inputNode.outputFormat(forBus: 0)
            
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recognitionFormat, block: { (buffer, when) in
                
                self.recognitionRequest.append(buffer)
                
            })
            
            audioEngine.prepare()
            
            try audioEngine.start()
            
           }
            
        }
        catch
        {
            
        }
    }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        speechRecognizer.delegate = self
        
        recordingButton.isEnabled = false
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            OperationQueue.main.addOperation({
            
            
            
            switch authStatus
            {
            case .authorized:
                self.recordingButton.isEnabled = true
                
            case .denied:
                self.recordingButton.isEnabled = false
                
                self.recordingButton.setTitle("User denied access to speech recognition", for: .disabled)
                
            case .restricted:
                self.recordingButton.isEnabled = false
                
                self.recordingButton.setTitle("Speech recognition is restricted on this device", for: .disabled)
                
            case .notDetermined:
                self.recordingButton.isEnabled = false
                
                self.recordingButton.setTitle("Speech recognition has not been yet authorised", for: .disabled)
            }
        })
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

