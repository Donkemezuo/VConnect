//
//  EditProfileView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    
    public lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .red
        
        return profileImageView
    }()
    
    public lazy var firstNameTxtField: UITextField = {
        let firstNameTxtField = UITextField()
        firstNameTxtField.backgroundColor = .white
        return firstNameTxtField
    }()
    
    public lazy var lastNameTxtField: UITextField = {
        let lastNameTxtField = UITextField()
        lastNameTxtField.backgroundColor = .white
        return lastNameTxtField
    }()
    
    public lazy var emailTxtField: UITextField = {
        let emailTxtField = UITextField()
        emailTxtField.backgroundColor = .white
        return emailTxtField
    }()
    
    public lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        return saveButton
    }()
    
    public lazy var dismissButton: UIButton = {
        let dismissButton = UIButton()
        return dismissButton
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        commonInit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setConstrains()
    }
    
    private func setConstrains() {
        setProfileImageViewConstrains()
        setFirstNameTxtFieldConstrains()
        setLastNameTxtFieldConstrains()
        setEmailTxtFieldConstrains()
        dismissButtonConstrains()
        setSaveButton()
        
    }
    
    private func setProfileImageViewConstrains(){
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    private func setFirstNameTxtFieldConstrains(){
        addSubview(firstNameTxtField)
        
        firstNameTxtField.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTxtField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20).isActive = true
        
        firstNameTxtField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        firstNameTxtField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        firstNameTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setLastNameTxtFieldConstrains(){
        addSubview(lastNameTxtField)
        
        lastNameTxtField.translatesAutoresizingMaskIntoConstraints = false
        
        lastNameTxtField.topAnchor.constraint(equalTo: firstNameTxtField.bottomAnchor, constant: 20).isActive = true
        
        lastNameTxtField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        lastNameTxtField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        lastNameTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    private func setEmailTxtFieldConstrains(){
        addSubview(emailTxtField)
        emailTxtField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTxtField.topAnchor.constraint(equalTo: lastNameTxtField.bottomAnchor, constant: 20).isActive = true
        
        emailTxtField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        emailTxtField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        emailTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    private func dismissButtonConstrains(){
        addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: emailTxtField.bottomAnchor, constant: 20).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setSaveButton(){
        addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: emailTxtField.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: dismissButton.trailingAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    

}
