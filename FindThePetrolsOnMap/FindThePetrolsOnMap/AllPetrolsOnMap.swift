//
//  AllPetrolsOnMap.swift
//  FindThePetrolsOnMap
//
//  Created by Dushko Cizaloski on 3/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation

import UIKit
import MapKit
import CoreLocation

//protocol HandleMapSearch: class {
//    func dropPinZoomIn(_ placemark:MKPlacemark)
//}

class AllPetrolsOnMap: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,UITabBarControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate
{
    
    var annotationPosition = 0
     var selectedPin: MKPlacemark?
    var placemark : MKPlacemark?
    var GetString : String!
    var tableview = UITableView()
    var MapViewItem: PetrolsTableViewController!
    @IBAction func userLocations(_ sender: Any) {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
        self.mapview.showsUserLocation = true
        
        let span = MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09)
        let coordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        self.mapview.setRegion(region, animated: true)
    }
    @IBOutlet var labelInfos: UILabel!
    @IBOutlet var mapview: MKMapView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        self.navigationController?.delegate = self
        selectedPin = placemark
        
        tableview.delegate = self
        
        let distance = PetrolItem[annotationPosition].distance?[annotationPosition]
        let distance1 = PetrolItem[annotationPosition + 1].distance?[annotationPosition + 1]
        let distance2 = PetrolItem[annotationPosition + 2].distance?[annotationPosition + 2]
        let distance3 = PetrolItem[annotationPosition + 3].distance?[annotationPosition + 3]
        let distance4 = PetrolItem[annotationPosition + 4].distance?[annotationPosition + 4]
        let distance5 = PetrolItem[annotationPosition + 5].distance?[annotationPosition + 5]
        let distance6 = PetrolItem[annotationPosition + 6].distance?[annotationPosition + 6]
        
        let address = PetrolItem[annotationPosition].addressPetrol?[annotationPosition]
        let address1 = PetrolItem[annotationPosition + 1].addressPetrol?[annotationPosition + 1]
        let address2 = PetrolItem[annotationPosition + 2].addressPetrol?[annotationPosition + 2]
        let address3 = PetrolItem[annotationPosition + 3].addressPetrol?[annotationPosition + 3]
        let address4 = PetrolItem[annotationPosition + 4].addressPetrol?[annotationPosition + 4]
        let address5 = PetrolItem[annotationPosition + 5].addressPetrol?[annotationPosition + 5]
        let address6 = PetrolItem[annotationPosition + 6].addressPetrol?[annotationPosition + 6]
        
        let latitude = PetrolItem[annotationPosition].lang![annotationPosition]
        let latitude1 = PetrolItem[annotationPosition + 1].lang![annotationPosition + 1]
        let latitude2 = PetrolItem[annotationPosition + 2].lang![annotationPosition + 2]
        let latitude3 = PetrolItem[annotationPosition + 3].lang![annotationPosition + 3]
        let latitude4 = PetrolItem[annotationPosition + 4].lang![annotationPosition + 4]
        let latitude5 = PetrolItem[annotationPosition + 5].lang![annotationPosition + 5]
        let latitude6 = PetrolItem[annotationPosition + 6].lang![annotationPosition + 6]
        
        let longitude = PetrolItem[annotationPosition].long?[annotationPosition]
        let longitude1 = PetrolItem[annotationPosition + 1].long?[annotationPosition + 1]
        let longitude2 = PetrolItem[annotationPosition + 2].long?[annotationPosition + 2]
        let longitude3 = PetrolItem[annotationPosition + 3].long?[annotationPosition + 3]
        let longitude4 = PetrolItem[annotationPosition + 4].long?[annotationPosition + 4]
        let longitude5 = PetrolItem[annotationPosition + 5].long?[annotationPosition + 5]
        let longitude6 = PetrolItem[annotationPosition + 6].long?[annotationPosition + 6]
//        let span = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude!)
        let coordinates1 = CLLocationCoordinate2D(latitude: latitude1, longitude: longitude1!)
        let coordinates2 = CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2!)
        let coordinates3 = CLLocationCoordinate2D(latitude: latitude3, longitude: longitude3!)
        let coordinates4 = CLLocationCoordinate2D(latitude: latitude4, longitude: longitude4!)
        let coordinates5 = CLLocationCoordinate2D(latitude: latitude5, longitude: longitude5!)
        let coordinates6 = CLLocationCoordinate2D(latitude: latitude6, longitude: longitude6!)
        
       
//        let region = MKCoordinateRegion(center: coordinates, span: span)
//        let region1 = MKCoordinateRegion(center: coordinates1, span: span)
//        let region2 = MKCoordinateRegion(center: coordinates2, span: span)
//        let region3 = MKCoordinateRegion(center: coordinates3, span: span)
//        let region4 = MKCoordinateRegion(center: coordinates4, span: span)
//        let region5 = MKCoordinateRegion(center: coordinates5, span: span)
//        let region6 = MKCoordinateRegion(center: coordinates6, span: span)
//        
//        self.mapview.setRegion(region, animated: true)
//        self.mapview.setRegion(region1, animated: true)
//        self.mapview.setRegion(region2, animated: true)
//        self.mapview.setRegion(region3, animated: true)
//        self.mapview.setRegion(region4, animated: true)
//        self.mapview.setRegion(region5, animated: true)
//        self.mapview.setRegion(region6, animated: true)
        
                                        let name = PetrolItem[annotationPosition].name[annotationPosition]
                                        
                                        let name1 = PetrolItem[annotationPosition + 1].name[annotationPosition + 1]
                                        
                                        let name2 = PetrolItem[annotationPosition + 2].name[annotationPosition + 2]
                                        
                                        let name3 = PetrolItem[annotationPosition + 3].name[annotationPosition + 3]
                                        
                                        let name4 = PetrolItem[annotationPosition + 4].name[annotationPosition + 4]
                                        
                                        let name5 = PetrolItem[annotationPosition + 5].name[annotationPosition + 5]
                                        
                                        let name6 = PetrolItem[annotationPosition + 6].name[annotationPosition + 6]
                                       // let annotation = MKPointAnnotation()
//        let getImgPetrol = PetrolItem[activePlace + 1].imgPetrol?[activePlace + 1]
                                        
                                        let title = PetrolItem[annotationPosition].title
                                        let title1 = PetrolItem[annotationPosition + 1].title
                                        let title2 = PetrolItem[annotationPosition + 2].title
                                        let title3 = PetrolItem[annotationPosition + 3].title
                                        let title4 = PetrolItem[annotationPosition + 4].title
                                        let title5 = PetrolItem[annotationPosition + 5].title
                                        let title6 = PetrolItem[annotationPosition + 6].title
        
                                        let addAnnotation = PetrolStation(name: [name], distance: [distance!],lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: [address!], lang: [0.0], long: [0.0], coordinates: coordinates, title: title)
                                        print(addAnnotation)
        let addAnnotation1 = PetrolStation(name: [name1], distance: [distance1!], lengthDiration: [""], imgPetrol: [(PetrolItem[activePlace + 1].imgPetrol?[activePlace + 1])!], addressPetrol: [address1!], lang: [0.0], long: [0.0], coordinates: coordinates1, title: title1)
                                        let addAnnotation2 = PetrolStation(name: [name2], distance: [distance2!], lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: [address2!], lang: [0.0], long: [0.0], coordinates: coordinates2, title: title2)
                                        let addAnnotation3 = PetrolStation(name: [name3], distance: [distance3!], lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: [address3!], lang: [0.0], long: [0.0], coordinates: coordinates3, title: title3)
                                        let addAnnotation4 = PetrolStation(name: [name4], distance: [distance4!], lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: [address4!], lang: [0.0], long: [0.0], coordinates: coordinates4, title: title4)
                                        let addAnnotation5 = PetrolStation(name: [name5], distance: [distance5!], lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: [address5!], lang: [0.0], long: [0.0], coordinates: coordinates5, title: title5)
                                        let addAnnotation6 = PetrolStation(name: [name6], distance: [distance6!], lengthDiration: [""], imgPetrol: [UIImage()], addressPetrol: [address6!], lang: [0.0], long: [0.0], coordinates: coordinates6, title: title6)
                                        
                                        mapview.addAnnotation(addAnnotation as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation1 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation2 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation3 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation4 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation5 as MKAnnotation)
                                        mapview.addAnnotation(addAnnotation6 as MKAnnotation)
                                        
                                        print(addAnnotation)
                                        mapview.delegate = self
                                        mapview.showsCompass = true
                                        //mapview.showsScale = true
                                        //mapview.showsTraffic = true
                                        
        

        
    }
    
    
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
                
//                var petrolsimage : [String] = ["lukoil.png","makpetrol.png","okta.jpeg","makoil.png", "detoil.jpeg", "petroloilkompani.png","amsmoil.jpg"]

                //Here this is a array of images
                
                
                let pinImage = PetrolItem[annotationPosition].imgPetrol?[annotationPosition]
                let pinImage1 = PetrolItem[annotationPosition + 1].imgPetrol?[annotationPosition + 1]
                let pinImage2 = PetrolItem[annotationPosition + 2].imgPetrol?[annotationPosition + 2]
                let pinImage3 = PetrolItem[annotationPosition + 3].imgPetrol?[annotationPosition + 3]
                let pinImage4 = PetrolItem[annotationPosition + 4].imgPetrol?[annotationPosition + 4]
                let pinImage5 = PetrolItem[annotationPosition + 5].imgPetrol?[annotationPosition + 5]
                let pinImage6 = PetrolItem[annotationPosition + 6].imgPetrol?[annotationPosition + 6]
                //Here we set the resize of the image
                let Setsize = CGSize(width: 30, height: 30)
                let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                let button1 = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                let button2 = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                let button3 = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                let button4 = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                let button5 = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                let button6 = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                button.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button1.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button2.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button3.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button4.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button5.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button6.setBackgroundImage(UIImage(named: "car_direction"), for: UIControlState())
                button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                button1.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                button2.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                button3.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                button4.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                button5.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                button6.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
                let info_button = UIButton(frame: CGRect(origin: CGPoint.zero, size: Setsize))
                info_button.setBackgroundImage(UIImage(named:"info_1"), for: UIControlState())
                info_button.addTarget(self, action: #selector(setInfo), for: .touchUpInside)
                UIGraphicsBeginImageContext(Setsize)
                pinImage?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
                pinImage1?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
                pinImage2?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
                pinImage3?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
                pinImage4?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
                pinImage5?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
                pinImage6?.draw(in: CGRect(x: 0, y: 0, width: Setsize.width, height: Setsize.height))
//                let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
//                let resizeImage1 = UIGraphicsGetImageFromCurrentImageContext()
//                let resizeImage2 = UIGraphicsGetImageFromCurrentImageContext()
//                let resizeImage3 = UIGraphicsGetImageFromCurrentImageContext()
//                let resizeImage4 = UIGraphicsGetImageFromCurrentImageContext()
//                let resizeImage5 = UIGraphicsGetImageFromCurrentImageContext()
//                let resizeImage6 = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                
                //view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                view.rightCalloutAccessoryView = info_button
//                let setImage = UIImage(named: "go_back2")
//                view.image = setImage
                let getAnnotation = annotation.coordinate.latitude
                let getAnnotation1 = annotation.coordinate.longitude
                if getAnnotation == PetrolItem[annotationPosition].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition ].coordinate.longitude
                {
                    view.image = UIImage.init(named: "LukOil1")
                }
                else if getAnnotation == PetrolItem[annotationPosition + 1].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition + 1].coordinate.longitude
                {
                
                    view.image = UIImage.init(named: "MakPetrol1")
                }
                else if getAnnotation == PetrolItem[annotationPosition + 2].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition + 2].coordinate.longitude
                {
                    
                    view.image = UIImage.init(named: "Okta1")
                }
                else if getAnnotation == PetrolItem[annotationPosition + 3].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition + 3].coordinate.longitude
                {
                    
                    view.image = UIImage.init(named: "MakOil1")
                }
                else if getAnnotation == PetrolItem[annotationPosition + 4].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition + 4].coordinate.longitude
                {
                    
                    view.image = UIImage.init(named: "DetOil1")
                }
                else if getAnnotation == PetrolItem[annotationPosition + 5].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition + 5].coordinate.longitude
                {
                    
                    view.image = UIImage.init(named: "PetrolOilKompani1")
                }
                else if getAnnotation == PetrolItem[annotationPosition + 6].coordinate.latitude && getAnnotation1 == PetrolItem[annotationPosition + 6].coordinate.longitude
                {
                    
                    view.image = UIImage.init(named: "ams2")
                }
//
//                    view.image = resizeImage3
//                
//                    view.image = resizeImage4
//                
//                    view.image = resizeImage5
//                
//                    view.image = resizeImage6
                
//                let myCustomImage = UIImageView.init(image: UIImage(named:"car_direction"))
//                let myCustomImage1 = UIImageView.init(image: resizeImage1)
//                let myCustomImage2 = UIImageView.init(image: resizeImage2)
//                let myCustomImage3 = UIImageView.init(image: resizeImage3)
//                let myCustomImage4 = UIImageView.init(image: resizeImage4)
//                let myCustomImage5 = UIImageView.init(image: resizeImage5)
//                let myCustomImage6 = UIImageView.init(image: resizeImage6)
//                view.leftCalloutAccessoryView = myCustomImage
//                view.leftCalloutAccessoryView = myCustomImage1
//                view.leftCalloutAccessoryView = myCustomImage2
//                view.leftCalloutAccessoryView = myCustomImage3
//                view.leftCalloutAccessoryView = myCustomImage4
//                view.leftCalloutAccessoryView = myCustomImage5
//                view.leftCalloutAccessoryView = myCustomImage6
                view.leftCalloutAccessoryView = button
                view.leftCalloutAccessoryView = button1
                view.leftCalloutAccessoryView = button2
                view.leftCalloutAccessoryView = button3
                view.leftCalloutAccessoryView = button4
                view.leftCalloutAccessoryView = button5
                view.leftCalloutAccessoryView = button6
                
                
            }
            
            return view
            
            
        }
        return nil
    }
    
    
    
//    func mapView(_ mapView: MKMapView,
//                 annotationView view: MKAnnotationView,
//                 calloutAccessoryControlTapped control: UIControl){
//        self.performSegue(withIdentifier:"ShowPin", sender: view)
//        self.title = (view.annotation?.title)!
//        let getNavigationItem = UINavigationBar()
//        getNavigationItem.backItem?.title = (view.annotation?.title)!
//        
//        
//    }
    
    func getDirections(){
        
        
        let latitude7 = PetrolItem[annotationPosition].lang![annotationPosition]
        let latitude8 = PetrolItem[annotationPosition + 1].lang![annotationPosition + 1]
        let latitude9 = PetrolItem[annotationPosition + 2].lang![annotationPosition + 2]
        let latitude10 = PetrolItem[annotationPosition + 3].lang![annotationPosition + 3]
        let latitude11 = PetrolItem[annotationPosition + 4].lang![annotationPosition + 4]
        let latitude12 = PetrolItem[annotationPosition + 5].lang![annotationPosition + 5]
        let latitude13 = PetrolItem[annotationPosition + 6].lang![annotationPosition + 6]
        
        let longitude7 = PetrolItem[annotationPosition].long?[annotationPosition]
        let longitude8 = PetrolItem[annotationPosition + 1].long?[annotationPosition + 1]
        let longitude9 = PetrolItem[annotationPosition + 2].long?[annotationPosition + 2]
        let longitude10 = PetrolItem[annotationPosition + 3].long?[annotationPosition + 3]
        let longitude11 = PetrolItem[annotationPosition + 4].long?[annotationPosition + 4]
        let longitude12 = PetrolItem[annotationPosition + 5].long?[annotationPosition + 5]
        let longitude13 = PetrolItem[annotationPosition + 6].long?[annotationPosition + 6]
        //var span1 = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
        let coordinates7 = CLLocationCoordinate2D(latitude: latitude7, longitude: longitude7!)
        let coordinates8 = CLLocationCoordinate2D(latitude: latitude8, longitude: longitude8!)
        let coordinates9 = CLLocationCoordinate2D(latitude: latitude9, longitude: longitude9!)
        let coordinates10 = CLLocationCoordinate2D(latitude: latitude10, longitude: longitude10!)
        let coordinates11 = CLLocationCoordinate2D(latitude: latitude11, longitude: longitude11!)
        let coordinates12 = CLLocationCoordinate2D(latitude: latitude12, longitude: longitude12!)
        let coordinates13 = CLLocationCoordinate2D(latitude: latitude13, longitude: longitude13!)
        
        let address = [NSTextCheckingStreetKey: "350 5th Avenue", NSTextCheckingCityKey: "New York", NSTextCheckingStateKey: "NY", NSTextCheckingZIPKey: "10118", NSTextCheckingCountryKey: "US"]
        
//        let address = [CNPostalAddressStreetKey: "350 5th Avenue",
//                       CNPostalAddressCityKey: "New York",
//                       CNPostalAddressStateKey: "NY",
//                       CNPostalAddressPostalCodeKey: "10118",
//                       CNPostalAddressISOCountryCodeKey: "US"]
        
        let placeMark1 = MKPlacemark(coordinate: coordinates7, addressDictionary: address)
        let placeMark2 = MKPlacemark(coordinate: coordinates8, addressDictionary: address)
        let placeMark3 = MKPlacemark(coordinate: coordinates9, addressDictionary: address)
        let placeMark4 = MKPlacemark(coordinate: coordinates10, addressDictionary: address)
        let placeMark5 = MKPlacemark(coordinate: coordinates11, addressDictionary: address)
        let placeMark6 = MKPlacemark(coordinate: coordinates12, addressDictionary: address)
        let placeMark7 = MKPlacemark(coordinate: coordinates13, addressDictionary: address)
        
        let mapItem1 = MKMapItem(placemark: placeMark1)
        let mapItem2 = MKMapItem(placemark: placeMark2)
        let mapItem3 = MKMapItem(placemark: placeMark3)
        let mapItem4 = MKMapItem(placemark: placeMark4)
        let mapItem5 = MKMapItem(placemark: placeMark5)
        let mapItem6 = MKMapItem(placemark: placeMark6)
        let mapItem7 = MKMapItem(placemark: placeMark7)
        
        mapItem1.name = "LukOil"
        
        mapItem2.name = "Mak-Petrol"
        mapItem3.name = "Okta"
        mapItem4.name = "Mak-Oil"
        mapItem5.name = "Det-Oil"
        mapItem6.name = "Petrol-Oil Kompani"
        mapItem7.name = "AMSM Petrol"
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey: MKMapType.standard.rawValue,
                             MKLaunchOptionsShowsTrafficKey: true ] as [String : Any]
        
        //var i = 0
        let currentUserLocation = MKMapItem.forCurrentLocation()
    
        let getMapAnnotation =  mapview.selectedAnnotations[0].coordinate.latitude
        let getMapAnnotation1 = mapview.selectedAnnotations[0].coordinate.longitude
            if getMapAnnotation == PetrolItem[activePlace + 1].lang![annotationPosition] || getMapAnnotation1 == PetrolItem[activePlace + 1].long![annotationPosition]
            {
            MKMapItem.openMaps(with: [currentUserLocation,mapItem1], launchOptions: launchOptions)
            }
            else if getMapAnnotation == PetrolItem[annotationPosition + 1].lang![annotationPosition + 1] || getMapAnnotation1 == PetrolItem[annotationPosition + 1].long![annotationPosition + 1]
            {
                MKMapItem.openMaps(with: [currentUserLocation,mapItem2], launchOptions: launchOptions)
            }
            else if getMapAnnotation == PetrolItem[annotationPosition + 2].lang![annotationPosition + 2] || getMapAnnotation1 == PetrolItem[annotationPosition + 2].long![annotationPosition + 2]
            {
                MKMapItem.openMaps(with: [currentUserLocation,mapItem3], launchOptions: launchOptions)
            }
            else if getMapAnnotation == PetrolItem[annotationPosition + 3].lang![annotationPosition + 3] || getMapAnnotation1 == PetrolItem[annotationPosition + 3].long![annotationPosition + 3]
            {
                MKMapItem.openMaps(with: [currentUserLocation,mapItem4], launchOptions: launchOptions)
            }
            else if getMapAnnotation == PetrolItem[annotationPosition + 4].lang![annotationPosition + 4] || getMapAnnotation1 == PetrolItem[annotationPosition + 4].long![annotationPosition + 4]
            {
                MKMapItem.openMaps(with: [currentUserLocation,mapItem5], launchOptions: launchOptions)
            }
            else if getMapAnnotation == PetrolItem[annotationPosition + 5].lang![annotationPosition + 5] || getMapAnnotation1 == PetrolItem[annotationPosition + 5].long![annotationPosition + 5]
            {
                MKMapItem.openMaps(with: [currentUserLocation,mapItem6], launchOptions: launchOptions)
            }
            else if getMapAnnotation == PetrolItem[annotationPosition + 6].lang![annotationPosition + 6] || getMapAnnotation1 == PetrolItem[annotationPosition + 6].long![annotationPosition + 6]
            {
                MKMapItem.openMaps(with: [currentUserLocation,mapItem7], launchOptions: launchOptions)
            }
  
        
    }

    func setInfo()
    {
        
        self.performSegue(withIdentifier: "ShowPin", sender: self)
        
    }
  //  func mapView(_ mapView: MKMapView,
  //               annotationView view: MKAnnotationView,
  //               calloutAccessoryControlTapped control: UIControl){
   //     self.performSegue(withIdentifier: "ShowPin", sender: self)
   // }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
           let getItems = PetrolItem
        //   let getItems1 = getItems[activePlace + 1]
            
            let getImage = PetrolItem[annotationPosition].imgPetrol?[annotationPosition]
            let getImage1 = PetrolItem[annotationPosition + 1].imgPetrol?[annotationPosition + 1]
            let getImage2 = PetrolItem[annotationPosition + 2].imgPetrol?[annotationPosition + 2]
            let getImage3 = PetrolItem[annotationPosition + 3].imgPetrol?[annotationPosition + 3]
            let getImage4 = PetrolItem[annotationPosition + 4].imgPetrol?[annotationPosition + 4]
            let getImage5 = PetrolItem[annotationPosition + 5].imgPetrol?[annotationPosition + 5]
            let getImage6 = PetrolItem[annotationPosition + 6].imgPetrol?[annotationPosition + 6]
            let getTitle = mapview.selectedAnnotations[0].title
            
            let getTitle1 = PetrolItem[annotationPosition].name[annotationPosition]
            let getTitle2 = PetrolItem[annotationPosition + 1].name[annotationPosition + 1]
            let getTitle3 = PetrolItem[annotationPosition + 2].name[annotationPosition + 2]
            let getTitle4 = PetrolItem[annotationPosition + 3].name[annotationPosition + 3]
            let getTitle5 = PetrolItem[annotationPosition + 4].name[annotationPosition + 4]
            let getTitle6 = PetrolItem[annotationPosition + 5].name[annotationPosition + 5]
            let getTitle7 = PetrolItem[annotationPosition + 6].name[annotationPosition + 6]
            
            let getAddress = PetrolItem[annotationPosition].addressPetrol?[annotationPosition]
            let getAddress1 = PetrolItem[annotationPosition + 1].addressPetrol?[annotationPosition + 1]
            let getAddress2 = PetrolItem[annotationPosition + 2].addressPetrol?[annotationPosition + 2]
            let getAddress3 = PetrolItem[annotationPosition + 3].addressPetrol?[annotationPosition + 3]
            let getAddress4 = PetrolItem[annotationPosition + 4].addressPetrol?[annotationPosition + 4]
            let getAddress5 = PetrolItem[annotationPosition + 5].addressPetrol?[annotationPosition + 5]
            let getAddress6 = PetrolItem[annotationPosition + 6].addressPetrol?[annotationPosition + 6]
            let label = UILabel()
            label.text = "Pushi Kur"
            var pinDetailsVC = InfosTableViewController()
          //  let getPrice: Int = Int(61.5)
            //GetString = getTitle!
            pinDetailsVC = segue.destination as! InfosTableViewController
            //GetText.text = label.text!
            //pinDetailsVC.GetString = self.GetString
            if segue.identifier == "ShowPin"
            {
                //var getInfos = GetDetailsTableViewCell()
                if getTitle! == getTitle1
                {
                    let getAllImages : UIImage = getImage!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress
                    pinDetailsVC.getImage = getAllImages
                    
               }
                else if getTitle! == getTitle2
                {
                    let getAllImages : UIImage = getImage1!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress1
                    pinDetailsVC.getImage = getAllImages
                    
                }
                else if getTitle! == getTitle3
                {
                    let getAllImages : UIImage = getImage2!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress2
                    pinDetailsVC.getImage = getAllImages
                    
                }
                else if getTitle! == getTitle4
                {
                    let getAllImages : UIImage = getImage3!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress3
                    pinDetailsVC.getImage = getAllImages
                    
                }
                else if getTitle! == getTitle5
                {
                    let getAllImages : UIImage = getImage4!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress4
                    pinDetailsVC.getImage = getAllImages
                    
                }
                else if getTitle! == getTitle6
                {
                    let getAllImages : UIImage = getImage5!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress5
                    pinDetailsVC.getImage = getAllImages
                    
                }
                else if getTitle! == getTitle7
                {
                    let getAllImages : UIImage = getImage6!
                    pinDetailsVC.GetString = getTitle!
                    pinDetailsVC.GetString1 = getAddress6
                    pinDetailsVC.getImage = getAllImages
                    
                }
                
                pinDetailsVC.navigationItem.title = mapview.selectedAnnotations[0].title!
                       let backItem = UIBarButtonItem()
                            backItem.title = ""
                            backItem.setBackButtonBackgroundImage(UIImage(named:"go_back2"), for: UIControlState(), barMetrics: .default)
                             navigationItem.backBarButtonItem = backItem
            
                
       }
}
//extension AllPetrolsOnMap: HandleMapSearch {
//    
//    func dropPinZoomIn(_ placemark: MKPlacemark){
//        // cache the pin
//        self.selectedPin = placemark
//        // clear existing pins
//        //mapview.removeAnnotations(mapview.annotations)
//        var annotation: MKAnnotationView = MKAnnotationView()
//        annotation = placemark.coordinate
//        annotation.title = placemark.name
//        
//        if let city = placemark.locality,
//            let state = placemark.administrativeArea {
//            annotation.subtitle = "\(city) \(state)"
//        }
//        
//        mapview.addAnnotation(annotation)
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegionMake(placemark.coordinate, span)
//        mapview.setRegion(region, animated: true)
//    }


    
    

//
//}

}
