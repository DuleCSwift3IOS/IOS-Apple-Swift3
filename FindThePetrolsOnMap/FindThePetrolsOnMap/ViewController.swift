//
//  ViewController.swift
//  FindThePetrolsOnMap
//
//  Created by Dushko Cizaloski on 2/16/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


var Latituded : [CLLocationDegrees] = [CLLocationDegrees()]
var Longituded : [CLLocationDegrees] = [CLLocationDegrees()]
var lastLocation :CLLocation = CLLocation()

/*
 import UIKit
 import GoogleMaps
 
 class ViewController: UIViewController {
 
 override func loadView() {
 let camera = GMSCameraPosition.camera(withLatitude: 41.887,
 longitude:-87.622,
 zoom:15)
 let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
 
 let marker = GMSMarker()
 marker.position = CLLocationCoordinate2D(latitude: 41.887, longitude: -87.622)
 marker.appearAnimation = kGMSMarkerAnimationPop
 marker.icon = UIImage(named: "flag_icon")
 marker.map = mapView
 
 view = mapView
 }
 }
 */

class ViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
var Distance : [String] = [""]
    
    @IBOutlet var mapview: MKMapView!
    
   
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
        self.mapview.showsUserLocation = true

        
        if activePlace != -1
        {
            //Get places details to display on the map
            
            if Petrolsitems.count > activePlace
            {
                //print(activePlace)
                if let distance = PetrolItem[activePlace].distance
                {
                    
                        if let address = PetrolItem[activePlace].addressPetrol
                        {
                           if let lang : [CLLocationDegrees] = PetrolItem[activePlace].lang
                           {
//                            Latituded = [lang[activePlace]]
                            if let long : [CLLocationDegrees] = PetrolItem[activePlace].long
                           {
                            if let latitude : [CLLocationDegrees] = lang
                                {
                                    if let longitude : [CLLocationDegrees] = long
                                    {
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let coordinate = CLLocationCoordinate2D(latitude: (latitude[activePlace]), longitude: longitude[activePlace])
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        
                                        self.mapview.setRegion(region, animated: true)
                                        
                                        let name = PetrolItem[activePlace].name[activePlace]
                                        
                                        let annotation = MKPointAnnotation()
                                        
                                        annotation.title = PetrolItem[activePlace].name[activePlace]
                                        
                                        let title = PetrolItem[activePlace].title
                                        
                                        let coordinatess = PetrolItem[activePlace].coordinate
                                        print(coordinatess)
                                        let addAnnotation = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        print(addAnnotation)
                                        let addAnnotation1 = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        let addAnnotation2 = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        let addAnnotation3 = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        let addAnnotation4 = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        let addAnnotation5 = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        let addAnnotation6 = PetrolStation(name: [name], distance: distance, lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: address, lang: [0.0], long: [0.0], coordinates: PetrolItem[activePlace].coordinate, title: title)
                                        
                                        mapview.addAnnotation(addAnnotation as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation1 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation2 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation3 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation4 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation5 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation6 as MKAnnotation)
                                        
                                        print(addAnnotation)
                                        mapview.delegate = self
                                        
                                 }
                             }
                          }
                      }
                    
                 }
            }
        }
    }
        
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    
//    // 1
    
    //This is code for implement a image with MKAnnotationView because MKPinAnntoationView have a standard image pin and she is a subclass of MKAnnotationView we can get MKAnnotation and we will set manualy image on a old pin image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PetrolStation {
            let identifier = "pinAnnotation"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
                
            } else {
                // 3
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                
                
                
                //here We put a coordinates where we like to show bubble with text information up on the pin image
                view.calloutOffset = CGPoint(x: -7, y: 7)
                
                
                //Here this is a array of images
                let pinImage = PetrolItem[activePlace].imgPetrol?[activePlace]
                
                //Here we set the resize of the image
                let size = CGSize(width: 30, height: 30)
                UIGraphicsBeginImageContext(size)
                pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                view.image = resizeImage
                
                //Here we like to put into bubble window a singe for detail Informations
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                view.image = resizeImage
                
                let myCustomImage = UIImageView.init(image: resizeImage)
                view.leftCalloutAccessoryView = myCustomImage
                /*
                 UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyCustomImage.png"]];
                 customPinView.leftCalloutAccessoryView = myCustomImage;
                 */
                
               // view.leftCalloutAccessoryView =
                //Here i will check how I may put multiple subTitles in Callout and see what will happend.That is not that but i am close
                
                let subTitle = UILabel()
                //let subTitle1 = UILabel()
                subTitle.text = "Address:\(PetrolItem[activePlace].addressPetrol![activePlace] as String) \nLenghtDuration: \(PetrolItem[activePlace].lengthDiration![activePlace] as String)"
                view.detailCalloutAccessoryView = subTitle

                let width = NSLayoutConstraint(item: subTitle, attribute: .width , relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
                
                
                let height = NSLayoutConstraint(item: subTitle, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
                
                
                subTitle.addConstraint(width)
                subTitle.addConstraint(height)
                subTitle.numberOfLines = 0
                

                
                
                
            }
        
            return view
        }
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get current position
        let sourcePlacemark = MKPlacemark(coordinate: locations.last!.coordinate, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        
        // Get destination position
        let lat1 = PetrolItem[activePlace].lang
        let lng1 = PetrolItem[activePlace].long
        let destinationCoordinates = CLLocationCoordinate2DMake((lat1?[activePlace])!, (lng1?[activePlace])!)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates, addressDictionary: nil)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // Create request
        let request = MKDirectionsRequest()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = MKDirectionsTransportType.automobile
       // request.transportType = MKDirectionsTransportType.walking
        request.requestsAlternateRoutes = false
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                let ariveTime = route.expectedTravelTime
                print("Print here a Distance: \(route.distance * 0.001), ETA: \(self.secondsToHoursMinutesSeconds(seconds: Int(ariveTime)))")
            } else {
                print("Error!")
            }
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}

