//
//  LaunchScreenViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/26/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation

class LaunchScreenViewController: UIViewController {
    
    public var authServices =  AppDelegate.authService
    public var vConnectUser: VConnectUser?
    public var allBookmarkedNGOs = [NGO]()
    public var allBookmarkedNGOIDs = [BookMark]()
    public var allNGOsInDataBase = [NGO]()
    public var coordinates = CLLocationCoordinate2D()
    public var locationManager = CLLocationManager()
    public var defaultCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
    
    public var geoCoder = CLGeocoder()
    private var timer: Timer!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
        queryNGODataBase()
        getBookmarkedNGOsID()
        fetchVConnectUser(withVConnectUserID: authServices.getCurrentVConnectUser()!.uid)
        
        view.backgroundColor = UIColor.init(hexString: "0072B1")
        navigationController?.isNavigationBarHidden =  true
        checkLocationAuthorizationStatus()
    }
    
    
    private func getUserLocationCoordinates() -> CLLocationCoordinate2D {
        guard let userLocationCoordinates = locationManager.location?.coordinate else {return defaultCoordinates }
        
        return userLocationCoordinates
    }
    
    private func queryNGODataBase(){
  DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching NGOs")
            }else if let querySnapShot = querySnapshot {
                var allRegisteredNGOs = [NGO]()
                
                for document in querySnapShot.documents {
                    let ngo = NGO.init(dict: document.data())
                    
                    allRegisteredNGOs.append(ngo)
                }
                
                self.allNGOsInDataBase = allRegisteredNGOs
                self.setupTimer()
            }
        }
    }
    
    
    private func setupTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
            self.segue()
        })
    }
    
    @objc private func segue(){

        let homeVC = HomeViewController(allRegisteredNGOs: allNGOsInDataBase, allBookmarkedNGOs: allBookmarkedNGOs, allBookmarkedDates: allBookmarkedNGOIDs, vConnectUser: vConnectUser!, userCoordinates: getUserLocationCoordinates())
        let navHomeVC = UINavigationController(rootViewController: homeVC)
        navHomeVC.isNavigationBarHidden = true
            self.present(navHomeVC, animated: true, completion: {
                if let app = UIApplication.shared.delegate as? AppDelegate {
                    
                    app.window?.rootViewController = navHomeVC
                    self.timer.invalidate()
                }
            })
        
    }
    
    private func getBookmarkedNGOsID(){
        guard let userID = authServices.getCurrentVConnectUser()?.uid else {return}
        
        DataBaseService.fetchVConnectBookMarkedNGOs(userID) { (error, bookmarks) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching book marks")
            } else if let bookmarks = bookmarks {
                self.allBookmarkedNGOIDs = bookmarks
                self.allBookmarkedNGOs.removeAll()
                
                for bookmarkedNGO in bookmarks {
                    for ngo in self.allNGOsInDataBase {
                        if bookmarkedNGO.ngoID == ngo.ngOID {
                            self.allBookmarkedNGOs.append(ngo)
                        }
                    }
                }
                
            }
        }
        
    }
    
    
    private func fetchVConnectUser(withVConnectUserID userID: String) {
        DataBaseService.fetchVConnectUserr(with: userID) { (error, vconnectUser) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching user")
            } else if let vConnectUser = vconnectUser {
                self.vConnectUser = vConnectUser
            }
        }
    }
    
    
    private func saveUserLocation(withUserCoordinates coordinates: CLLocation) {
        guard let vConnectUser = authServices.getCurrentVConnectUser() else {return}

        geoCoder.reverseGeocodeLocation(coordinates) { (placemark, error) in
            if error != nil {
                
            } else if let placemark = placemark?.first {
                DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.location).document(vConnectUser.uid).updateData([VConnectUserCollectionKeys.location: placemark.locality ?? "" ])
            }
        }
        
        
    }
    
    
    private func locationAuthorizationStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            let location = CLLocation(latitude: getUserLocationCoordinates().latitude, longitude: getUserLocationCoordinates().longitude)
            print("The coordinates are \(getUserLocationCoordinates())")
            saveUserLocation(withUserCoordinates: location)
            locationManager.startUpdatingLocation()
            
        case .denied:
    self.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            break
        case .restricted:
        self.locationManager.requestWhenInUseAuthorization()
            
        case .notDetermined:
            showAlert(title: "Error", message: "Please authorize location services to enable VConnect connect you to the right resources") { (elert) in
                self.locationManager.requestWhenInUseAuthorization()
            }
        default:
            break
        }
    }
    
    
    private func setupLocationManager(){
        locationManager.delegate = self
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

    private func setupAnimationView(){
        
        let lauchScreenAnimationView = AnimationView(name: "4693-loading")
        view.addSubview(lauchScreenAnimationView)
        lauchScreenAnimationView.translatesAutoresizingMaskIntoConstraints = false
        lauchScreenAnimationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lauchScreenAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lauchScreenAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lauchScreenAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        lauchScreenAnimationView.play()
        lauchScreenAnimationView.animationSpeed = 0.8
        lauchScreenAnimationView.loopMode = .playOnce
       //lex lauchScreenAnimationView
    }

}

extension LaunchScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorizationStatus()
    }
}
