//
//  SignUpViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import CoreLocation

class SignUpViewController: UIViewController {
    @IBOutlet weak var VConnectLogoImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.backgroundColor = .white
        return activityIndicator
    }()
    
    private lazy var loadingView: UIView = {
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.layer.cornerRadius = 10
        return loadingView
    }()
    
    @IBOutlet weak var VConnectNameLabel: UILabel!
    
    private var authServices = AppDelegate.authService
    
    private var allNGOs = [NGO]()
    
    private var vConnectUser: VConnectUser!
    @IBOutlet weak var contentView: UIView!
    
     private var allBookmarkedNGOIDs = [BookMark]()
    
    @IBOutlet weak var createAccountScrollView: UIScrollView!
    private var allBookmarkedNGOs = [NGO]()
    public var coordinates = CLLocationCoordinate2D()
    public var locationManager = CLLocationManager()
    public var defaultCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
    public var geoCoder = CLGeocoder()
    
    @IBOutlet weak var showAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
           view.backgroundColor = UIColor.init(hexString: "0072B1")
        contentView.backgroundColor = .clear
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
     authServices.authServiceCreateNewVConnectUserAccountDelegate =  self
        createAccountButton.setTitleColor(UIColor(hexString: "0072B1"), for: .normal)
        createAccountScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.width * 2)
        setupViewDetails()
        setupLabelTitles()
        dimissKeyboardView()
    }
    
    private func setupActivityIndicator(){
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width/2, y: loadingView.frame.size.height/2)
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    private func dimissKeyboardView(){
        
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(screenTap)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func showSignInView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
       
    }
    
    private func setupViewDetails(){
        VConnectLogoImageView.image = UIImage.init(named: "VCConectLogo")
        VConnectNameLabel.text = "VConnect"
        VConnectNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        VConnectNameLabel.textColor = .white
    }

    private func setupLabelTitles(){
          navigationItem.hidesBackButton = true 
        firstNameTextField.placeholder = "Enter FirstName"
        firstNameTextField.textAlignment = .center
        lastNameTextField.placeholder = "Enter LastName"
        lastNameTextField.textAlignment = .center
        emailTextField.placeholder = "Enter Email"
        emailTextField.textAlignment = .center
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.textAlignment = .center
        createAccountButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        createAccountButton.backgroundColor = .white
        createAccountButton.layer.cornerRadius = 20
        showAccountButton.titleLabel?.textColor = .white
        showAccountButton.titleLabel?.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 14)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        createAccountScrollView.contentInset = contentInsets
        createAccountScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        createAccountScrollView.contentInset.bottom = keyboardFrame.height
    }
    private func getUserLocationCoordinates() -> CLLocationCoordinate2D {
        guard let userLocationCoordinates = locationManager.location?.coordinate else {return defaultCoordinates }
        
        return userLocationCoordinates
    }
    
    
    private func locationAuthorizationStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            let location = CLLocation(latitude: getUserLocationCoordinates().latitude, longitude: getUserLocationCoordinates().longitude)
            saveUserLocation(withUserCoordinates: location)
            locationManager.startUpdatingLocation()
            
        case .denied:
            self.locationManager.requestWhenInUseAuthorization()
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
    
    private func checkLocationAuthorizationStatus(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            locationAuthorizationStatus()
        } else {
            showAlert(title: "Needed", message: "Please authorize location services for VConnect to serve you better")
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
    
    private func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func segueToHomeVC(){
        
                showAlert(title: "Success", message: "Welcome to VConnect. Our amazing community of support") { (alert) in
                    let homeViewController = HomeViewController(allRegisteredNGOs: self.allNGOs, allBookmarkedNGOs: self.allBookmarkedNGOs, allBookmarkedDates: self.allBookmarkedNGOIDs, vConnectUser: self.vConnectUser, userCoordinates: self.getUserLocationCoordinates())
                    
                    homeViewController.modalTransitionStyle = .crossDissolve
                    homeViewController.modalPresentationStyle = .overFullScreen
                    self.present(homeViewController, animated: true, completion: {
                        self.activityIndicator.stopAnimating()
                        self.loadingView.removeFromSuperview()
                    })
                }
    }

    
    @IBAction func CreateAccountButtonPressed(_ sender: UIButton) {
        setupActivityIndicator()
        
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
        !firstName.isEmpty,
        !lastName.isEmpty,
        !email.isEmpty,
            !password.isEmpty else {
                
                showAlert(title: "Error", message: "Email and Password required")
                self.activityIndicator.stopAnimating()
                self.loadingView.removeFromSuperview()
                return
        }
        
        authServices.createNewVConnectUser(firstName: firstName, lastName: lastName, email: email, password: password)
    }

}

extension SignUpViewController: AuthServiceCreateNewVConnectUserAccountDelegate {
    func didReceiveErrorCreatingVConnectUserAccount(_ authService: AuthService, error: Error) {
        showAlert(title: "Error", message: "\(error.localizedDescription) encountered while creating VConnect account") { (alert) in
            self.activityIndicator.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    func didCreateNewVConnectUserAccount(_ authService: AuthService, vconnectUser: VConnectUser) {
        
        DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching NGOs")
            }else if let querySnapShot = querySnapshot {
                var allRegisteredNGOs = [NGO]()
                
                for document in querySnapShot.documents {
                    let ngo = NGO.init(dict: document.data())
                    
                    allRegisteredNGOs.append(ngo)
                }
                
                self.allNGOs = allRegisteredNGOs
                
                guard let userID = authService.getCurrentVConnectUser()?.uid else {return}
                DataBaseService.fetchVConnectUserr(with: userID) { (error, vconnectUser) in
                    if let error = error {
                        self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching user")
                    } else if let vConnectUser = vconnectUser {
                        self.vConnectUser = vConnectUser
                        self.checkLocationAuthorizationStatus()
                        DataBaseService.fetchVConnectBookMarkedNGOs(userID) { (error, bookmarks) in
                            if let error = error {
                                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching book marks")
                            } else if let bookmarks = bookmarks {
                                print("Fetching User")
                                self.allBookmarkedNGOIDs = bookmarks
                                self.allBookmarkedNGOs.removeAll()
                                for bookmarkedNGO in bookmarks {
                                    for ngo in self.allNGOs {
                                        if bookmarkedNGO.ngoID == ngo.ngOID {
                                            self.allBookmarkedNGOs.append(ngo)
                                        }
                                    }
                                }
                                self.checkLocationAuthorizationStatus()
                            }
                        }
                    }
                    }
    }

}
}
}

extension SignUpViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status  {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            break
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            self.segueToHomeVC()
        }
    }
}
