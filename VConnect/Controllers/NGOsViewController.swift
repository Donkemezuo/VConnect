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
    
    //let nGOsView = NGOsView()
    let nGOsTableView = NGOsTableView()
    private var geoCoder = CLGeocoder()
    private var annotations = [MKAnnotation]()
    private var coordinates = CLLocationCoordinate2D()
    public var locationManager = CLLocationManager()
    var defaultCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
    var authServices = AppDelegate.authService
    var vConnectUser: VConnectUser?
    
    private var allNGOs = [NGO]() {
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
    
    
    private var nGOCategories = ["Domestic Violence", "Child issues", "Sexual Assault", "Human Rights", "Women", "Youth Development", "Education", "Housing", "Leadership"]
    
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
        view.addSubview(nGOsTableView)
        view.backgroundColor = UIColor.init(hexString: "f0f0f0")
        self.navigationController?.isNavigationBarHidden = true
        nGOsTableView.nGOsTableView.delegate =  self
        nGOsTableView.nGOsTableView.dataSource = self
        nGOsTableView.categoriesCollectionView.dataSource = self
        nGOsTableView.categoriesCollectionView.delegate = self
        checkLocationAuthorizationStatus()
        configureSettingsButton()
        getLoggedInUser(with: authServices.getCurrentVConnectUser()!.uid)
        fetchAllNGOData()

    }
    
    private func getUserLocationCoordinates() -> CLLocationCoordinate2D{
        guard let userLocationCoordinates = locationManager.location?.coordinate else {
            return defaultCoordinates
        }
        
        return userLocationCoordinates
    }
    
    private func fetchAllNGOData(){
        DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while fetching NGOs data")
            }else if let querySnapshot = querySnapshot{
                var allNGOs = [NGO]()
                
                for document in querySnapshot.documents {
                    let ngo = NGO.init(dict: document.data())
                    allNGOs.append(ngo)
                }
                self.allNGOs = allNGOs
            }
            
        
        }
    }
    
    private func getLoggedInUser(with userID: String){
        
        DataBaseService.fetchVConnectUserr(with: userID) { (error, vconnectUser) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) while fetching Logged in User")
            } else if let vconnectUser = vconnectUser {
                self.vConnectUser = vconnectUser
            }
        }
    }
    
    private func configureSettingsButton(){
        nGOsTableView.settingButton.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)
    }

    
    @objc private func settingButtonClicked(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingsVC = storyBoard.instantiateViewController(withIdentifier: "ProfileSettingsViewController") as? ProfileSettingsViewController else {return }
        settingsVC.vConnectUser = vConnectUser
        settingsVC.modalPresentationStyle = .overCurrentContext
        settingsVC.modalTransitionStyle = .crossDissolve
        present(settingsVC, animated: true)
        
    }
    
    private func generateMilesDifference(with cell: NGOsTableViewCell){
        
        let userCurrentLocation = CLLocation(latitude: getUserLocationCoordinates().latitude, longitude: getUserLocationCoordinates().longitude)
        let nGOLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let distanceFromNGO = userCurrentLocation.distance(from: nGOLocation)
        let distanceInMiles = distanceFromNGO/1609.344
        cell.nGOMiles.text = String(format: "%.0f", distanceInMiles) + " " + "Miles"
        
    }
    
    
    func getImages(ngo: NGO, completionHandler: @escaping ([NGOImages]) -> Void) {
        
        var nGOImages = [NGOImages]()
        DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(ngo.ngOID).collection(Constants.nGOImagesPath).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error.localizedDescription) encountered while fetching documents")
            } else if let snapShot = snapshot {
                
                for document in snapShot.documents {
                    let ngoImage = NGOImages.init(dict: document.data())
                    nGOImages.append(ngoImage)
                    
                }
                
                completionHandler(nGOImages)
                
            }
        }
    }
    
    private func saveUserLocation(with coordinates: CLLocation){
        
        guard let user = authServices.getCurrentVConnectUser() else {return}
        
        geoCoder.reverseGeocodeLocation(coordinates) { (placeMark, error) in
            if error != nil {
                
            } else if let placemark = placeMark?.first{
                DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.location).document(user.uid).updateData([VConnectUserCollectionKeys.location: placemark.locality ?? ""])
            }
        }
        
        
        
    }

    
    
    private func locationAuthorizationStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            let location = CLLocation(latitude: getUserLocationCoordinates().latitude, longitude: getUserLocationCoordinates().longitude)
               saveUserLocation(with: location)
            locationManager.startUpdatingLocation()

        case .denied:
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
        @unknown default:
            break
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
            showAlert(title: "Needed", message: "Please authorize location services for VConnect to serve you better")
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
    
    
    private func setRatingValue(with ratingValue: Double, on nGOCell: NGOsTableViewCell) {
        nGOCell.cosmosView.settings.starMargin = 3.5
        nGOCell.cosmosView.settings.totalStars =  5
        nGOCell.cosmosView.settings.updateOnTouch = false
       nGOCell.cosmosView.rating = ratingValue
      nGOCell.cosmosView.settings.fillMode = .half
        nGOCell.cosmosView.settings.starSize = 25
    }
    
    
}

extension NGOsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? vConnectUserSearchedNGOsInCategory.count : allNGOs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nGOsCell = tableView.dequeueReusableCell(withIdentifier: "NGOsTableViewCell", for: indexPath) as? NGOsTableViewCell else {return UITableViewCell()}
        
    let nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOs[indexPath.row]
    nGOsCell.nGOName.text = nGOToSet.ngoName
    nGOsCell.nGOCity.text = nGOToSet.ngoCity
    nGOsCell.selectionStyle = .none
    nGOsCell.backgroundColor = .clear
    nGOsCell.containerView.backgroundColor = UIColor.white
        generateMilesDifference(with: nGOsCell)
    setRatingValue(with: nGOToSet.ratingsValue, on: nGOsCell)
    return nGOsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOs[indexPath.row]
        getImages(ngo: nGOToSet) { (ngoImages) in
            nGOToSet.ngoImagesURL = ngoImages
            let nGODetailViewController = NGODetailsViewController(nGO: nGOToSet)
            self.navigationController?.pushViewController(nGODetailViewController, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    
    
}

extension NGOsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorizationStatus()
    }
    
}

extension NGOsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nGOCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else {return UICollectionViewCell()}
        let category = nGOCategories[indexPath.row]
        categoryCell.categoryNameLabel.text = category
        categoryCell.backgroundColor = .clear
        categoryCell.layer.borderWidth = 1
        categoryCell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        categoryCell.layer.cornerRadius = 5
        return categoryCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nGOsInCategory = nGOCategories[indexPath.row]
        isSearching = true
        vConnectUserSearchedNGOsInCategory = allNGOs.filter {$0.ngoCategory == nGOsInCategory}
        
        if vConnectUserSearchedNGOsInCategory.count == 0 {
            showAlert(title: "Sorry", message: "There are currently no registered NGOs in the \(nGOsInCategory) Category. Please check back later as we continue to grow our support community. Thank you")
            isSearching = false
        }

    }
    
    
}
