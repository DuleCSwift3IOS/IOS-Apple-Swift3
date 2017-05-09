//
//  ViewController.swift
//  NewestInstagramCloneApp
//
//  Created by Dushko Cizaloski on 4/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
/*
 'use strict';
 
 console.log('Loading function');
 
 exports.handler = (event, context, callback) => {
 //console.log('Received event:', JSON.stringify(event, null, 2));
 const modifiedEvent = event;
 
 // Check for the event type
 if (event.eventType === 'SyncTrigger') {
 // Modify value for a key
 if ('SampleKey1' in event.datasetRecords) {
 modifiedEvent.datasetRecords.SampleKey1.newValue = 'ModifyValue1';
 modifiedEvent.datasetRecords.SampleKey1.op = 'replace';
 }
 
 // Remove a key
 if ('SampleKey2' in event.datasetRecords) {
 modifiedEvent.datasetRecords.SampleKey2.op = 'remove';
 }
 
 // Add a key
 if (!('SampleKey3' in event.datasetRecords)) {
 modifiedEvent.datasetRecords.SampleKey3 = {
 newValue: 'ModifyValue3',
 op: 'replace',
 };
 }
 }
 
 callback(null, modifiedEvent);
 };

 */
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, AWSIdentityProviderManager {

    var googleIdToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil
        {
            googleIdToken = user.authentication.idToken
            //print(idToken, name, email)
            singInToCognito(user: user)
        }
        else
        {
            print("\(error.localizedDescription)")
        }
    }
    
    func logins() -> AWSTask<NSDictionary> {
        let result = NSDictionary(dictionary: [AWSIdentityProviderGoogle: googleIdToken])
        
        return AWSTask(result: result)
    }
    
    func singInToCognito(user: GIDGoogleUser!)
    {
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest2, identityPoolId: "us-west-2:b608fb1d-40c9-406b-b33e-57c249afc0de", identityProviderManager: self)
        
        let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        credentialsProvider.getIdentityId().continueWith { (task: AWSTask) -> Any? in
            if (task.error != nil)
            {
                print(task.error)
                return nil
            }
            
            let syncClient = AWSCognito.default()
            let dataset = syncClient.openOrCreateDataset("myDataSet")
            
            dataset.setString(user.profile.email, forKey: "email")
            dataset.setString(user.profile.name, forKey: "name")
            
            let result = dataset.synchronize()
            
            result?.continueWith(block: { (task:AWSTask) -> Any? in
                if task.error != nil
                {
                    print(task.error)
                }
                else
                {
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "login", sender: self)
                    })
                }
                return nil
            })
            
            return nil
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

