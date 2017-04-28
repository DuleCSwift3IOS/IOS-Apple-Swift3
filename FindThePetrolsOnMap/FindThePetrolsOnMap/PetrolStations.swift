//
//  PetrolStations.swift
//  FindThePetrolsOnMap
//
//  Created by Dushko Cizaloski on 2/17/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import MapKit
class PetrolStation: NSObject, MKAnnotation
{
    
    var name: [String]
    var title: String?
    var distance : [String]?
    var lengthDiration : [String]?
    var imgPetrol : [UIImage]?
    var addressPetrol : [String]?
    var lang : [CLLocationDegrees]?
    var long : [CLLocationDegrees]?
    var coordinate: CLLocationCoordinate2D
    
    
    init (name: [String?], distance: [String], lengthDiration: [String], imgPetrol: [UIImage], addressPetrol: [String], lang: [CLLocationDegrees], long: [CLLocationDegrees], coordinates: CLLocationCoordinate2D, title: String? )
    {
        
        self.name = name as! [String]
        self.distance = distance
        self.lengthDiration = lengthDiration
        self.imgPetrol = imgPetrol
        self.addressPetrol = addressPetrol
        self.lang = lang
        self.long = long
        self.coordinate = coordinates
        self.title = title
        
        super.init()
    }
    
    
}
