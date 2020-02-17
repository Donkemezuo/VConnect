//
//  SignInViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreLocation


enum SignInState {
    case bookmark, review
}

protocol VConnectusersignInDelegate: AnyObject {
    func successfullySignedIn()
    func createReview()
}

class SignInViewController: UIViewController {
    
    
    
    weak var bookMarkDelegate: VConnectusersignInDelegate?
    
    var userSignInState: SignInState?
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var VConnectLogoImageView: UIImageView!
    
    @IBOutlet weak var VConnectNameLabel: UILabel!
    
    @IBOutlet weak var VConnectLoginEmailTextField: UITextField!
    
    @IBOutlet weak var VConnectLoginPasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
  
    @IBOutlet weak var newAccount: UIButton!
    
    var nGOID = ""
    
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
    private var authService = AppDelegate.authService
    private var vConnectUser: VConnectUser!
    private var allNGOs = [NGO]()
    private var allBookmarkedNGOIDs = [BookMark]()
    private var allBookmarkedNGOs = [NGO]()
    public var coordinates = CLLocationCoordinate2D()
    public var locationManager = CLLocationManager()
    public var defaultCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
    public var geoCoder = CLGeocoder()
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.init(hexString: "0072B1")
        authService.authServiceExistingVConnectUserAccountDelegate = self
        contentView.backgroundColor = .clear
        setupViewDetails()
        setupLabelTitles()
        loginScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.width * 2)
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        LoginButton.setTitleColor(UIColor(hexString: "0072B1"), for: .normal)
        VConnectLoginEmailTextField.delegate = self
        VConnectLoginPasswordTextField.delegate = self
        dimissKeyboardView()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        loginScrollView.contentInset = contentInsets
        loginScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func segueToSignUpView(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "AuthenticationView", bundle: nil)
        let signUpView = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        signUpView.ngoID = nGOID
        signUpView.signupBookMarkDelegate = self
        signUpView.signupState = userSignInState
    navigationController?.pushViewController(signUpView, animated: true)
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        loginScrollView.contentInset.bottom = keyboardFrame.height * 0.65
    }
    
    private func setupActivityIndicator(){
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width/2, y: loadingView.frame.size.height/2)
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }

    private func setupViewDetails(){
        VConnectLogoImageView.image = UIImage.init(named: "VCConectLogo")
        VConnectNameLabel.text = "VConnect"
        VConnectNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        VConnectNameLabel.textColor = .white
        
    }
    
    private func setupLabelTitles(){
        VConnectLoginEmailTextField.placeholder = "Enter Email"
        VConnectLoginEmailTextField.textAlignment = .center
        VConnectLoginPasswordTextField.placeholder = "Enter Password"
        VConnectLoginPasswordTextField.textAlignment = .center
        LoginButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        LoginButton.backgroundColor = .white
        LoginButton.layer.cornerRadius = 20
        LoginButton.setTitle("Login", for: .normal)
        LoginButton.setTitleColor(UIColor.init(hexString: "0072B1"), for: .normal)
        newAccount.titleLabel?.font =  UIFont(name: "HelveticaNeue-BoldItalic", size: 14)
        newAccount.setTitle("New User? Create account", for: .normal)
        newAccount.setTitleColor(.white, for: .normal)
        
    }
    
    @IBAction func SignInButtonPressedButton(_ sender: UIButton) {
        setupActivityIndicator()
        guard let vConnectUserEmail = VConnectLoginEmailTextField.text, let vConnectUserPassword = VConnectLoginPasswordTextField.text,
        !vConnectUserEmail.isEmpty,
            !vConnectUserPassword.isEmpty else {
                showAlert(title: "Error", message: "Email and Password required")
                self.activityIndicator.stopAnimating()
                self.loadingView.removeFromSuperview()
                return
        }
        
        authService.signInExistingVConnectUserAccount(email: vConnectUserEmail, password: vConnectUserPassword)
    }
    
    private func dimissKeyboardView(){
        
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(screenTap)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
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
            showAlert(title: "Needed", message: "Please authorize location services to enable VConnect connect you to the right resources") { (elert) in
                self.locationManager.requestWhenInUseAuthorization()
                print("This is happening")
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
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func saveUserLocation(withUserCoordinates coordinates: CLLocation) {
        guard let vConnectUser = authService.getCurrentVConnectUser() else {return}
        
        geoCoder.reverseGeocodeLocation(coordinates) { (placemark, error) in
            if error != nil {
                
            } else if let placemark = placemark?.first {
                DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.location).document(vConnectUser.uid).updateData([VConnectUserCollectionKeys.location: placemark.locality ?? ""])
            }
        }
    }
    
}

extension SignInViewController: AuthServiceExistingVConnectAccountDelegate {
    func didReceiveErrorSigningToVConnectExistingAccount(_ authService: AuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription) { (alert) in
            self.activityIndicator.stopAnimating()
            self.loadingView.removeFromSuperview()
            
        }
    }
    
    func didSignInToExistingVConnectUserAccount(_ authService: AuthService, user: User) {
        bookMarkDelegate?.successfullySignedIn()
        bookMarkDelegate?.createReview()
        dismiss(animated: true)
    }
    
    private func segueToHomeVC(){
    let homeViewController = HomeViewController()
        homeViewController.allUserBookMarkIDs = allBookmarkedNGOIDs
        homeViewController.allUserBookmarks = allBookmarkedNGOs
        homeViewController.vConnectUser = vConnectUser
        homeViewController.userCoordinates = getUserLocationCoordinates()
        let homeVC = UINavigationController(rootViewController: homeViewController)
        self.present(homeVC, animated: true, completion: {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.window?.rootViewController = homeVC
                self.activityIndicator.stopAnimating()
                self.loadingView.removeFromSuperview()
            }
        })
    }
    
  
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            VConnectLoginEmailTextField.resignFirstResponder()
            return true
        case 1:
            VConnectLoginPasswordTextField.resignFirstResponder()
            return true
        default:
            return false
        }
    }
    
    
}
extension SignInViewController: CLLocationManagerDelegate {
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
          // self.segueToHomeVC()
            print("Yes")
        }

    }
    
}

extension SignInViewController: VConnectUserCreatedAccountDelegate {
    
    func successfullyCreatedVConnectAccountFromBookMark() {
        guard let signInState = userSignInState else {return}
        guard Auth.auth().currentUser != nil else {return}
        switch signInState {
        case .bookmark:
   self.bookMarkDelegate?.successfullySignedIn()
        case .review:
    self.bookMarkDelegate?.createReview()
        }
        
    }
    
    
}
