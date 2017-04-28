//
//  IntentHandler.swift
//  SiriIntentsExtension
//
//  Created by Dushko Cizaloski on 4/22/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension,INSendMessageIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let content = intent.content
        {
            print("Content \(content)")
            
            let response = INStringResolutionResult.success(with: content)
            
            completion(response)
        }
        else
        {
            let response = INStringResolutionResult.needsValue()
            
            completion(response)
        }
    }
    
    func confirm(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        //Check if user logged in
        
        let isloggedin = true
        
        if isloggedin
        {
            completion(INSendMessageIntentResponse.init(code: .success, userActivity: nil))
        }
        else
        {
            completion(INSendMessageIntentResponse.init(code: .failureRequiringAppLaunch, userActivity: nil))
        }
    }
    
    func handle(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        
    }
    
    }

