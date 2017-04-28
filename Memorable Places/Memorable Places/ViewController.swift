//
//  ViewController.swift
//  Memorable Places
//
//  Created by Dushko Cizaloski on 2/12/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        if activePlace == -1
        {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        else
        {
        
            //Get place details to display on the map
            if Places.count > activePlace
            {
                if let name = Places[activePlace]["name"]
                {
                    if let lan = Places[activePlace]["lan"]
                    {
                        
                        if let lon = Places[activePlace]["lon"]
                        {
                            
                            if let latitude = Double(lan)
                            {
                                
                                if let longitude = Double(lon)
                                {
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    self.map.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    
                                    annotation.coordinate = coordinate
                                    
                                    annotation.title = name
                                    
                                    self.map.addAnnotation(annotation)
                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
    
    }

    func longPress(gestureRecognizer: UIGestureRecognizer)
    {
        if gestureRecognizer.state == UIGestureRecognizerState.began
        {
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            var title = ""
            if error != nil
            {
                print(error)
            }
            else
            {
            
                if let placemark = placemarks?[0]
                {
                
                    if placemark.subThoroughfare != nil
                    {
                        title += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil
                    {
                        title += placemark.thoroughfare!
                    }
                    
                }
            }
        
            if title == ""
            {
                title = "Added \(NSDate())"
            }
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = newCoordinate
            annotation.title = title
            
            self.map.addAnnotation(annotation)

            Places.append(["name":title, "lan": String(newCoordinate.latitude), "lon": String(newCoordinate.longitude)])
            
            UserDefaults.standard.object(forKey: "Places")
            
        }
    }
            }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.map.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

