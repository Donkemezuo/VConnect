//
//  VConnectUserProfileSettingsView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/30/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class VConnectUserProfileSettingsView: UIView {
    
    public lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = UIColor.lightGray
        return profileImageView
    }()

    public lazy var firstNameLabel: UILabel = {
        let firstNameLabel = UILabel()
        firstNameLabel.text = "First Name"
        firstNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
       firstNameLabel.textColor = UIColor.lightGray
        //firstNameLabel.backgroundColor = .white
        
        return firstNameLabel
    }()
    
    public lazy var firstNameInputTextField: UITextField = {
        let firstNameInputTextField = UITextField()
        firstNameInputTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        firstNameInputTextField.textColor = .white
        firstNameInputTextField.backgroundColor = UIColor.lightGray
        
        return firstNameInputTextField
    }()
    
    public lazy var lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.text = "Last Name"
        lastNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
      lastNameLabel.textColor = UIColor.lightGray
        //lastNameLabel.backgroundColor = .white
        return lastNameLabel
    }()
    
    public lazy var lastNameInputTextField: UITextField = {
        let lastNameInputTextField = UITextField()
        lastNameInputTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        lastNameInputTextField.textColor = .white
         lastNameInputTextField.backgroundColor = UIColor.lightGray
        
        return lastNameInputTextField
    }()
    
    public lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
       emailLabel.textColor = UIColor.lightGray
        //emailLabel.backgroundColor = .white
        
        return emailLabel
    }()
    
    public lazy var emailInputTextField: UITextField = {
        let emailInputTextField = UITextField()
        emailInputTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        emailInputTextField.textColor = .white
        emailInputTextField.backgroundColor = UIColor.lightGray
        return emailInputTextField
    }()
    
    public lazy var saveButton:UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .red
        saveButton.backgroundColor = UIColor.lightGray
        saveButton.layer.cornerRadius = 20
        
        return saveButton
    
    }()
    
    public lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .red
        cancelButton.layer.cornerRadius = 20
        return cancelButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setupConstrains()
    }
    
    private func setupConstrains() {
        setProfileImageViewConstrains()
        setFirstNameLabelConstrains()
        setFirstNameTextFieldConstrains()
        setLastNameLabelConstrains()
        setLastNameTextFieldConstrains()
        setEmailLabelConstrains()
        setEmailTextFieldConstrains()
        setCancelButtonConstrains()
        setSaveButtonConstrains()
        
        
    }
    
    private func setProfileImageViewConstrains(){
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setFirstNameLabelConstrains(){
        addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5).isActive = true
        firstNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        firstNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        firstNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setFirstNameTextFieldConstrains(){
        addSubview(firstNameInputTextField)
        firstNameInputTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameInputTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor).isActive = true
        firstNameInputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        firstNameInputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        firstNameInputTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setLastNameLabelConstrains(){
        addSubview(lastNameLabel)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.topAnchor.constraint(equalTo: firstNameInputTextField.bottomAnchor, constant: 5).isActive = true
        lastNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lastNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lastNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setLastNameTextFieldConstrains(){
        addSubview(lastNameInputTextField)
        lastNameInputTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameInputTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor).isActive = true
        lastNameInputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lastNameInputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lastNameInputTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
    }
    
    private func setEmailLabelConstrains(){
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: lastNameInputTextField.bottomAnchor, constant: 5).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setEmailTextFieldConstrains(){
        addSubview(emailInputTextField)
        emailInputTextField.translatesAutoresizingMaskIntoConstraints = false
        emailInputTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor).isActive = true
        emailInputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        emailInputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        emailInputTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setCancelButtonConstrains(){
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: emailInputTextField.bottomAnchor, constant: 10).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setSaveButtonConstrains(){
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: emailInputTextField.bottomAnchor, constant: 10).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 200).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    
    
}
