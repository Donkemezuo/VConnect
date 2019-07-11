//
//  SignUpViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var VConnectLogoImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var VConnectNameLabel: UILabel!
    
    private var authServices = AppDelegate.authService
    
    override func viewDidLoad() {
        super.viewDidLoad()
           view.backgroundColor = UIColor.init(hexString: "033860")
     authServices.authServiceCreateNewVConnectUserAccountDelegate =  self
        
        setupViewDetails()
        setupLabelTitles()
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
    }
    
    
    @IBAction func CreateAccountButtonPressed(_ sender: UIButton) {
        
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
        !firstName.isEmpty,
        !lastName.isEmpty,
        !email.isEmpty,
            !password.isEmpty else {
                showAlert(title: "Missing fields require filling", message: "Please fill in all missing fields")
                return
        }
        
        authServices.createNewVConnectUser(firstName: firstName, lastName: lastName, email: email, password: password)
        
    }

}

extension SignUpViewController: AuthServiceCreateNewVConnectUserAccountDelegate {
    func didReceiveErrorCreatingVConnectUserAccount(_ authService: AuthService, error: Error) {
        showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while creating VConnect account")
    }
    
    func didCreateNewVConnectUserAccount(_ authService: AuthService, vconnectUser: VConnectUser) {
        showAlert(title: "Success", message: "Welcome to VConnect. Our amazing community of support") { (alert) in
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "NGOsViewController") as! NGOsViewController
            mainTabBarController.modalTransitionStyle = .crossDissolve
            mainTabBarController.modalPresentationStyle = .overFullScreen
            self.present(mainTabBarController, animated: true)
        }
    }
    
    
}
