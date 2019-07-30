//
//  SignInViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import FirebaseAuth
@IBDesignable

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var VConnectLogoImageView: UIImageView!
    
    @IBOutlet weak var VConnectNameLabel: UILabel!
    
    @IBOutlet weak var VConnectLoginEmailTextField: UITextField!
    
    @IBOutlet weak var VConnectLoginPasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
  
    @IBOutlet weak var newAccount: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor = UIColor.init(hexString: "0072B1")
        authService.authServiceExistingVConnectUserAccountDelegate = self
        setupViewDetails()
        setupLabelTitles()
        navigationController?.isNavigationBarHidden = true
        LoginButton.setTitleColor(UIColor(hexString: "0072B1"), for: .normal)
    
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
    }
    
    @IBAction func SignInButtonPressedButton(_ sender: UIButton) {
        setupActivityIndicator()
        
        guard let vConnectUserEmail = VConnectLoginEmailTextField.text, let vConnectUserPassword = VConnectLoginPasswordTextField.text,
        !vConnectUserEmail.isEmpty,
            !vConnectUserPassword.isEmpty else {
                showAlert(title: "Error", message: "Email and Password required")
                return
        }
        
        authService.signInExistingVConnectUserAccount(email: vConnectUserEmail, password: vConnectUserPassword)
    }
}

extension SignInViewController: AuthServiceExistingVConnectAccountDelegate {
    func didReceiveErrorSigningToVConnectExistingAccount(_ authService: AuthService, error: Error) {
        showAlert(title: "Error: \(error.localizedDescription) while loggin in", message: error.localizedDescription)
    }
    
    func didSignInToExistingVConnectUserAccount(_ authService: AuthService, user: User) {
        
        //guard let displayName = user.displayName else {return}
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "NGOsViewController") as! HomeViewController
        homeViewController.modalTransitionStyle = .crossDissolve
        homeViewController.modalPresentationStyle = .overFullScreen
        
        self.present(homeViewController, animated: true, completion: {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.window?.rootViewController = homeViewController
                
                self.activityIndicator.stopAnimating()
                self.loadingView.removeFromSuperview()
            }
        })
        
//        showAlert(title: "Success", message: "Welcome back \(displayName)") { (alert) in
//             let storyboard = UIStoryboard(name: "Main", bundle: nil)
//               let homeViewController = storyboard.instantiateViewController(withIdentifier: "NGOsViewController") as! HomeViewController
//            homeViewController.modalTransitionStyle = .crossDissolve
//            homeViewController.modalPresentationStyle = .overFullScreen
//
//            self.present(homeViewController, animated: true, completion: {
//                if let app = UIApplication.shared.delegate as? AppDelegate {
//                    app.window?.rootViewController = homeViewController
//                }
//            })
//
//            //self.present(homeViewController, animated: true)
//        }
    }
    
    
}
