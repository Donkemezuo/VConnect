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
        guard let displayName = user.displayName else {return}
        showAlert(title: "Success", message: "Welcome back \(displayName)") { (alert) in
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let homeViewController = storyboard.instantiateViewController(withIdentifier: "NGOsViewController") as! HomeViewController
            homeViewController.modalTransitionStyle = .crossDissolve
            homeViewController.modalPresentationStyle = .overFullScreen
            
            self.present(homeViewController, animated: true, completion: {
                if let app = UIApplication.shared.delegate as? AppDelegate {
                    app.window?.rootViewController = homeViewController
                }
            })
            
            //self.present(homeViewController, animated: true)
        }
    }
    
    
}
