//
//  RiderLocationViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dushko Cizaloski on 4/19/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import MapKit
import Parse
class RiderLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    
    var riderLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var riderUsernameLocation = ""
    
    @IBAction func acceptReqest(_ sender: Any) {
        
        let query = PFQuery(className: "riderRequest")
        
        query.whereKey("username", equalTo: riderUsernameLocation)
        
        query.findObjectsInBackground { (objects, error) in
            if let riderLocations = objects
            {
                for riderLocation in riderLocations
                {
                    riderLocation["driverResponded"] = PFUser.current()?.username
                    
                    riderLocation.saveInBackground()
                    
                    let requestCLLocation = CLLocation(latitude: self.riderLocation.latitude , longitude: self.riderLocation.longitude)
                    
                    CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: { (placemarks, error) in
                        if let placemarks = placemarks
                        {
                            if placemarks.count > 0
                            {
                                let mKPlaceMarks = MKPlacemark(placemark: placemarks[0])
                                
                                let mapItem = MKMapItem(placemark: mKPlaceMarks)
                                
                                mapItem.name = self.riderUsernameLocation
                                
                                let lanchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                            
                                mapItem.openInMaps(launchOptions: lanchOptions)
                            }
                        }
                    })
                }
            }
        }
        
    }
    @IBOutlet var acceptRequestButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let region = MKCoordinateRegion(center: riderLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = riderLocation
        
        annotation.title = riderUsernameLocation
        
        map.addAnnotation(annotation)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
