//
//  PetrolsTableViewController.swift
//  FindThePetrolsOnMap
//
//  Created by Dushko Cizaloski on 2/16/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
var activePlace = -1
var mapview = MKMapView()
var getViewControllerDistance: ViewController = ViewController()

var petrolsname : [String] = ["LukOil","MakPetrol","Okta","MakOil","DetOil", "PetrolOilKompani","AMSMPetrol"]
var petrolsdistance : [String] = []//["0km","0km","0.5km","0.8km","0.4km","0.7km","0.33km","42.005738","21.384007"]

var petrolsLengthdDuration : [String] = ["5min","7min","10min","8min","3.5min","15min","30min"]
var petrolsimage : [UIImage] = [UIImage (named:"lukoil.png")!, UIImage (named:"makpetrol.png")!,UIImage (named:"okta.jpeg")!, UIImage (named:"makoil.png")!,UIImage (named: "detoil.jpeg")!, UIImage (named:"petroloilkompani.png")!,UIImage (named:"amsmoil.jpg")!]
var petrolsAddress : [String] = ["Skupi, Скупи 120, Скопје 1000, Македонија","Kiril i Metodij 4, Скопје 1000, Македонија","Булевар Партизански Одреди b.b., Скопје 1000, Македонија","Булевар Србија bb, Скопје 1000, Македонија","Перо Наков, Скопје 1000, Македонија","Волковска, Скопје 1060, Македонија","бул.Mitropolit Teodosij Gologanov br.51, Skopje 1000, Македонија"]
var petrolsLangitude : [CLLocationDegrees] = [CLLocationDegrees(41.987627), CLLocationDegrees(41.990127), CLLocationDegrees(42.054890), CLLocationDegrees(41.978991), CLLocationDegrees(41.996560), CLLocationDegrees(42.025065), CLLocationDegrees(42.024066)]
var petrolsLongitude : [CLLocationDegrees] = [CLLocationDegrees(21.473000), CLLocationDegrees(21.444009), CLLocationDegrees(21.451174), CLLocationDegrees(21.465836), CLLocationDegrees(21.480100), CLLocationDegrees(21.350216), CLLocationDegrees(21.433731)]
var coordinates1 = [CLLocationCoordinate2D(latitude: petrolsLangitude[0], longitude: petrolsLongitude[0])]
var coordinates2 = [CLLocationCoordinate2D(latitude: petrolsLangitude[1], longitude: petrolsLongitude[1])]
var coordinates3 = [CLLocationCoordinate2D(latitude: petrolsLangitude[2], longitude: petrolsLongitude[2])]
var coordinates4 = [CLLocationCoordinate2D(latitude: petrolsLangitude[3], longitude: petrolsLongitude[3])]
var coordinates5 = [CLLocationCoordinate2D(latitude: petrolsLangitude[4], longitude: petrolsLongitude[4])]
var coordinates6 = [CLLocationCoordinate2D(latitude: petrolsLangitude[5], longitude: petrolsLongitude[5])]
var coordinates7 = [CLLocationCoordinate2D(latitude: petrolsLangitude[6], longitude: petrolsLongitude[6])]
var Petrolsitems: [[PetrolStation]] = []
var PetrolItem  = [PetrolStation]()

class PetrolsTableViewController: UITableViewController, UISearchResultsUpdating, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate, CustomSearchControllerDelegate {
    
 let getSearchBar = UISearchBar()
    @IBOutlet var tableview: UITableView!
    
    func informationOfPetrols()
    {
//        let serchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
//        
//        //serchBar.showsCancelButton = true
//        serchBar.delegate = self
//        self.tableview.tableHeaderView = serchBar
        
        
        
        let locationManager = CLLocationManager()
        let mapview = MKMapView()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
        mapview.showsUserLocation = true
        mapview.showsCompass = true
        
        let userLocation = CLLocation()
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        let getUserLocation = mapview.setRegion(region, animated: true)
        print(getUserLocation)
        var getShowListDistances : [CLLocation] = [CLLocation(latitude: petrolsLangitude[0], longitude: petrolsLongitude[0])]
        var getShowListDistances1 : [CLLocation] = [CLLocation(latitude: petrolsLangitude[1], longitude: petrolsLongitude[1])]
        var getShowListDistances2 : [CLLocation] = [CLLocation(latitude: petrolsLangitude[2], longitude: petrolsLongitude[2])]
        var getShowListDistances3 : [CLLocation] = [CLLocation(latitude: petrolsLangitude[3], longitude: petrolsLongitude[3])]
        var getShowListDistances4 : [CLLocation] = [CLLocation(latitude: petrolsLangitude[4], longitude: petrolsLongitude[4])]
        var getShowListDistances5 : [CLLocation] = [CLLocation(latitude: petrolsLangitude[5], longitude: petrolsLongitude[5])]
        var getShowListDistances6 : [CLLocation] = [CLLocation(latitude: petrolsLangitude[6], longitude: petrolsLongitude[6])]
        
        
        
        
        var showgetedDistances : [CLLocationDistance] = [CLLocation(latitude: ((locationManager.location?.coordinate.latitude)!), longitude: ((locationManager.location?.coordinate.longitude)!)).distance(from: getShowListDistances[0])]
        var showgetedDistances1 : [CLLocationDistance] = [CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!).distance(from: getShowListDistances1[0])]
        var showgetedDistances2 : [CLLocationDistance] = [CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!).distance(from: getShowListDistances2[0])]
        var showgetedDistances3 : [CLLocationDistance] = [CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!).distance(from: getShowListDistances3[0])]
        var showgetedDistances4 : [CLLocationDistance] = [CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!).distance(from: getShowListDistances4[0])]
        var showgetedDistances5 : [CLLocationDistance] = [CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!).distance(from: getShowListDistances5[0])]
        var showgetedDistances6 : [CLLocationDistance] = [CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!).distance(from: getShowListDistances6[0])]
        
        petrolsdistance.append(String(format: "%.2f", showgetedDistances[0] * 0.001))
        petrolsdistance.append(String(format: "%.2f", showgetedDistances1[0] * 0.00160934))
        petrolsdistance.append(String(format: "%.2f", showgetedDistances2[0] * 0.00160934))
        petrolsdistance.append(String(format: "%.2f", showgetedDistances3[0] * 0.00160934))
        petrolsdistance.append(String(format: "%.2f", showgetedDistances4[0] * 0.00160934))
        petrolsdistance.append(String(format: "%.2f", showgetedDistances5[0] * 0.00160934))
        petrolsdistance.append(String(format: "%.2f", showgetedDistances6[0] * 0.00160934))
        
        
        
       // print(getShowListDistances[0])
        
       // print(getFirstRoute)
        
       // print(petrolsdistance)
        
        
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates1[activePlace + 1], title: "Luk-oil"))
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates2[activePlace + 1], title: "Mak-Petrol"))
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates3[activePlace + 1], title: "Okta"))
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates4[activePlace + 1], title: "Mak-Oil"))
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates5[activePlace + 1], title: "Det-Oil"))
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates6[activePlace + 1], title: "Petrol-Oil Kompani"))
        PetrolItem.append(PetrolStation(name: petrolsname, distance: petrolsdistance, lengthDiration: petrolsLengthdDuration, imgPetrol: petrolsimage, addressPetrol: petrolsAddress, lang: petrolsLangitude , long: petrolsLongitude, coordinates: coordinates7[activePlace + 1], title:"AMSM Petrol"))
        PetrolItem.append(PetrolStation(name: [""], distance: petrolsdistance, lengthDiration: [""], imgPetrol: [], addressPetrol: [""], lang: [0.0], long: [0.0], coordinates: coordinates1[activePlace + 1], title: ""))
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        Petrolsitems.append(PetrolItem)
        
        print(PetrolItem[0].distance!)
        
        activePlace = -1
        self.tableview.reloadData()
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    var resultSearchController: UISearchController!
    
    var shouldShowSearchResults = false
    
    var filterByName = [String]()
    var filterByAddress = [String]()
    
    var customSearchController: CustomSearchController!
    
    func configureCustomSeachController()
    {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: tableview.frame.size.width, height: 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.yellow, searchBarTintColor: UIColor.red)
        
        
        customSearchController.customSearchBar.placeholder = "Search in this awsome bar..."
        
        customSearchController.customDelegate = self
        
        tableview.tableHeaderView = customSearchController.customSearchBar
    }
    
    func configurationSearchController()
    {
        self.resultSearchController = ({
            
            let controller = UISearchController(searchResultsController: nil)
            
            controller.searchResultsUpdater = self
            
            controller.dimsBackgroundDuringPresentation = false
            
            controller.hidesNavigationBarDuringPresentation = false
            
            controller.searchBar.placeholder = "Search here..."
            
            controller.searchBar.delegate = self
            
            controller.searchBar.sizeToFit()
            
            //  controller.view.removeFromSuperview()
            // controller.loadViewIfNeeded()
            //            let _ = controller.view
            self.tableview.tableHeaderView = controller.searchBar
            
            
            return controller
        })()
        //self.tableview.reloadData()

    }
    
    var getFirstRoute = MKRoute().distance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationOfPetrols()
        
       // configurationSearchController()
        
        configureCustomSeachController()
        
        // Get current position
        let locations : [CLLocation]! = [CLLocation()]
        
        
        let sourcePlacemark = MKPlacemark(coordinate: locations.last!.coordinate, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        
        // Get destination position
        let lat1 = petrolsLangitude
        let lng1 = petrolsLongitude
        let destinationCoordinates = CLLocationCoordinate2DMake(lat1[activePlace + 1], (lng1[activePlace + 1]))
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
        
      var getDirections = directions.calculate { response, error in
           if let route = response?.routes.first
           {
            let ariveTime = route.expectedTravelTime
            
            self.getFirstRoute += route.distance
            
             print(self.getFirstRoute)
//            print("Print here a Distance: \((route?.distance)! * 0.001), ETA: \(self.secondsToHoursMinutesSeconds(seconds: Int(ariveTime!)))")
//            //  petrolsdistance.append(String(format: "%.2f", Double((route?.distance)!) * 0.001))
            
            
        }
        
    }
     
        print(getDirections)
}
    
//    func addRadiusCircle(location: CLLocation){
//        mapview.delegate = self
//        let circle = MKCircle(center: location.coordinate, radius: 10000 as CLLocationDistance)
//        mapview.add(circle)
//    }
//    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if overlay is MKCircle {
//            let circle = MKCircleRenderer(overlay: overlay)
//            circle.strokeColor = UIColor.red
//            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
//            circle.lineWidth = 1
//            return circle
//        } else {
//            return MKOverlayRenderer()
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults
        {
        return self.filterByName.count
        }
        else
        {
            return PetrolItem.count - 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ShowTheListCell  = tableview.dequeueReusableCell(withIdentifier: "PetrolCell", for: indexPath) as! ShowTheListCell
        let itemes = Petrolsitems[indexPath.row]
        

                if  shouldShowSearchResults
            {
                PetrolItem[indexPath.row].name[indexPath.row] = filterByName[indexPath.row]
            }
                
        else
        {
            
            PetrolItem[indexPath.row] = itemes[indexPath.row]

        }
        
                    cell.showNamePetrol.text = itemes[indexPath.row].name[indexPath.row]
                    cell.showDistancePetrol.text = "\(itemes[indexPath.row].distance![indexPath.row]) km"
                    cell.showLengthDurationPetrol.text = itemes[indexPath.row].lengthDiration?[indexPath.row]
                    cell.showImagePetrol.image = (itemes[indexPath.row].imgPetrol?[indexPath.row])!
                    cell.showAddressPetrol.text = itemes[indexPath.row].addressPetrol?[indexPath.row]
        
        return cell 
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = resultSearchController.searchBar.text
        
        filterByName = PetrolItem[0].name.filter({ (petrol) -> Bool in
            let petrolText : NSString = petrol as NSString
            
            return (petrolText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        if filterByName.count == 0
        {
            shouldShowSearchResults = true
        }
        else
        {
            shouldShowSearchResults = false
        }
//        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//            filteredNFLTeams = unfilteredNFLTeams.filter { team in
//                return team.lowercased().contains(searchText.lowercased())
//            }
//            
//        } else {
//            filteredNFLTeams = unfilteredNFLTeams
//        }
//        
//        filterByName.removeAll(keepingCapacity: false)
//        filterByAddress.removeAll(keepingCapacity: false)
//        
//        if let searchText = searchController.searchBar.text, !searchText.isEmpty
//        {
//            filterByName = PetrolItem[0].name.filter({ (petrol) -> Bool in
//                return petrol.uppercased().contains(searchText.uppercased())
//            })
//            
//            filterByAddress = PetrolItem[0].name.filter({ (petrol) -> Bool in
//                return petrol.uppercased().contains(searchText.uppercased())
//            })
//        }
//        else
//        {
//            filterByName = PetrolItem[0].name
//            filterByAddress = PetrolItem[0].addressPetrol!
//            
//        }
//        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
//        //let array = (tableData as NSArray).filtered(using: searchPredicate)
//        let array1 = (PetrolItem[0].name as NSArray).filtered(using: searchPredicate)
//        let array2 = (PetrolItem[0].addressPetrol! as NSArray).filtered(using: searchPredicate)
//        filterTableData = array1 as! [String]
//        filterTableData = array2 as! [String]
        
        self.tableView.reloadData()
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activePlace = indexPath.row
        
    }
  
//        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//    
//            resultSearchController.isActive = true
//            tableview.reloadData()
//            //searchBar.setShowsCancelButton(true, animated: true)
//        }
//    
//        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            
//            resultSearchController.isActive = false
//            tableview.reloadData()
////           self.tableview.setContentOffset(CGPoint(x: 0, y: -22), animated: true)
////            searchBar.resignFirstResponder()
//    
//        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults
        {
            resultSearchController.isActive = true
            tableview.reloadData()
        }
        resultSearchController.searchBar.resignFirstResponder()
    }
    
    
    
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableview.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if shouldShowSearchResults {
            shouldShowSearchResults = true
            tableview.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableview.reloadData()
    }
    
    
    func didChangeSearchText(_ searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filterByName = PetrolItem[0].name.filter({ (petrols) -> Bool in
            let petrolsText: NSString = petrols as NSString
            
            return (petrolsText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableview.reloadData()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tableView.setContentOffset(CGPoint(x: 0, y: 40), animated: true)
//        getSearchBar.showsCancelButton = false
//        
//    }
//

//    

//    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(false, animated: true)
//    }

    
    
    
}
