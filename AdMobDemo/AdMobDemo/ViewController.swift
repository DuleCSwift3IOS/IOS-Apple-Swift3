//
//  ViewController.swift
//  AdMobDemo
//
//  Created by Dushko Cizaloski on 4/21/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController, UIAlertViewDelegate {

    @IBAction func displayAd(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    var interstitial: GADInterstitial!
    
    @IBOutlet var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView.adUnitID = "ca-app-pub-1369613104516787/7963768357"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    fileprivate func startNewGame() {
        createAndLoadInterstitial()
        
        // Set up a new game.
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-1369613104516787/7963768357")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        print("Here this is a request.testDevices number \(request.keywords)")
        request.testDevices = [kGADSimulatorID]
        interstitial.load(request)
    }
    
}

