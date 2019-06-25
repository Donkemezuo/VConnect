//
//  NGOsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NGOsViewController: UIViewController {
    
    let nGOsView = NGOsView()
    let nGOsTableView = NGOsTableView()
    private var geoCoder = CLGeocoder()
    private var annotations = [MKAnnotation]()
    private var coordinates = CLLocationCoordinate2D()
    public var locationManager = CLLocationManager()
    var defaultCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
    private var allNGOsInCategory = [NGO](){
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
    
    private var vConnectUserSearchedNGOsInCategory = [NGO](){
        
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
    
    private var nGOsMapView = NGOsMapView(){
        didSet {
            nGOsMapView.mapView.reloadInputViews()
        }
    }
    
    
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        navigationItem.title = "NGOs"
        nGOsTableView.nGOsTableView.delegate =  self
        nGOsTableView.nGOsTableView.dataSource = self
        nGOsMapView.mapView.delegate = self
        nGOsView.searchBar.delegate = self
        setupSegmentedControl()
        nGOsView.resourcesView.addSubview(nGOsTableView)
        nGOsView.toggleView.tintColor = .white
        makeAnnotations()
        checkLocationAuthorizationStatus()
    }
    
    init(nGOsInCategory: [NGO]){
        super.init(nibName: nil, bundle: nil)
        self.allNGOsInCategory = nGOsInCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func getUserLocationCoordinates() -> CLLocationCoordinate2D{
        guard let userLocationCoordinates = locationManager.location?.coordinate else {
            return defaultCoordinates
        }
        
        return userLocationCoordinates
    }

    
    private func generateMilesDifference(with cell: NGOsTableViewCell){
        
        let userCurrentLocation = CLLocation(latitude: getUserLocationCoordinates().latitude, longitude: getUserLocationCoordinates().longitude)
        let nGOLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        print(nGOLocation)
        print(coordinates)
        
        let distanceFromNGO = userCurrentLocation.distance(from: nGOLocation)
        let distanceInMiles = distanceFromNGO/1609.344
        cell.nGOMiles.text = String(format: "%.0f", distanceInMiles) + " " + "Miles"
        
    }
    
    private func locationAuthorizationStatus(){
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            getUserLocationCoordinates()
            break
        case .denied:
//            showAlert(title: "Needed", message: "Please authorize location services to enable VConnect connect you to the right resources")
    self.locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
    showAlert(title: "Error", message: "Please authorize location services to enable VConnect connect you to the right resources") { (elert) in
            self.locationManager.requestWhenInUseAuthorization()
            }
        case .notDetermined:
            showAlert(title: "Error", message: "Please authorize location services to enable VConnect connect you to the right resources") { (elert) in
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    private func setupLocationManager(){
        locationManager.delegate =  self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    private func checkLocationAuthorizationStatus(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            locationAuthorizationStatus()
        } else {
            showAlert(title: "Need", message: "Please authorize location services for VConnect to serve you better")
        }
    }
    
    
    
    private func setupSegmentedControl(){
        nGOsView.toggleView.addTarget(self, action: #selector(switchONViews), for: .valueChanged)
    }
    
    @objc private func switchONViews(){
        switch nGOsView.toggleView.selectedSegmentIndex {
        case 0:
            nGOsMapView.removeFromSuperview()
            nGOsView.resourcesView.addSubview(nGOsTableView)
        case 1:
            nGOsTableView.removeFromSuperview()
            nGOsView.resourcesView.addSubview(nGOsMapView)
        default:
            return
            
        }
    }
    
    private func generateNGOLocationCoordinates(with NGOFullAddress: String, completionHandler:  @escaping(Error?, CLLocationCoordinate2D?) -> Void){
        
        GoogleAddressAPIClient.getAddressCoordinates(fullAddress: NGOFullAddress) { (error, fetchResults) in
            if let error = error {
                completionHandler(error, nil)
  
            } else if let fetchedResults = fetchResults {
                let coordinatesFromFetchedResult = fetchedResults.results.first?.geometry
                guard let latitude = coordinatesFromFetchedResult?.location.lat, let longitude = coordinatesFromFetchedResult?.location.lng else {
                    return
                }
           completionHandler(nil, CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                
            }
        }
    }
    
    
    private func makeAnnotations() {
    nGOsMapView.mapView.removeAnnotations(annotations)
        
        for ngo in allNGOsInCategory {
     generateNGOLocationCoordinates(with: ngo.fullAddress) { (error, coordinate) in
                if let error = error {
                   self.showAlert(title: "Error", message: error.localizedDescription)
                } else if let addressCoordinates = coordinate {
                    self.coordinates = addressCoordinates
                    print(self.coordinates)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(addressCoordinates.latitude, addressCoordinates.longitude)
              
            let region = MKCoordinateRegion(center: addressCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    self.nGOsMapView.mapView.setRegion(region, animated: true)
                    annotation.title = ngo.ngoName
                    self.annotations.append(annotation)
                    self.nGOsMapView.mapView.addAnnotations(self.annotations)
                    self.nGOsMapView.mapView.showAnnotations(self.annotations, animated: true)
                }
            }

        }
 
    }
    
    private func setRatingValue(with ratingValue: Double, on nGOCell: NGOsTableViewCell) {
        nGOCell.cosmosView.settings.starMargin = 3.5
        nGOCell.cosmosView.settings.totalStars =  5
        nGOCell.cosmosView.settings.updateOnTouch = false
       nGOCell.cosmosView.rating = ratingValue
      nGOCell.cosmosView.settings.fillMode = .half
    }
    
    
}

extension NGOsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        nGOsView.searchBar.resignFirstResponder()
        
        vConnectUserSearchedNGOsInCategory = allNGOsInCategory.filter{$0.ngoCity == nGOsView.searchBar.text}
        nGOsTableView.nGOsTableView.reloadData()
        
        if nGOsView.searchBar.text == "" {
            isSearching = false
        nGOsTableView.nGOsTableView.reloadData()
        
        }

        
    }
    
}
extension NGOsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? vConnectUserSearchedNGOsInCategory.count : allNGOsInCategory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nGOsCell = tableView.dequeueReusableCell(withIdentifier: "NGOsTableViewCell", for: indexPath) as? NGOsTableViewCell else {return UITableViewCell()}
        
    let nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOsInCategory[indexPath.row]
   nGOsCell.nGOName.text = nGOToSet.ngoName
   nGOsCell.nGOCity.text = nGOToSet.ngoCity
   nGOsCell.backgroundColor = .clear
   nGOsCell.layer.borderWidth = 0.5
   nGOsCell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
   nGOsCell.layer.cornerRadius = 2
    generateMilesDifference(with: nGOsCell)
    setRatingValue(with: nGOToSet.ratingsValue, on: nGOsCell)
    return nGOsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOsInCategory[indexPath.row]
        let nGODetailViewController = NGODetailsViewController(nGO: nGOToSet)
        self.navigationController?.pushViewController(nGODetailViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}

extension NGOsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
    }
    
}

extension NGOsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Callouts") as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Callouts")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            annotationView?.annotation =  annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let callOutButtonClicked = view.annotation else {return}
        
        if let nGOname = callOutButtonClicked.title, let nGO = (allNGOsInCategory.filter{$0.ngoName == nGOname}).first {
            
            let detailVC = NGODetailsViewController(nGO: nGO)
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
        
    }
    
    
}
