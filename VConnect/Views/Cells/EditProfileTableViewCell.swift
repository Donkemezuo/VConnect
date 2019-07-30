//
//  EditProfileTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {
    
    public lazy var profileImage: UIImageView = {
        
        let profileImage = UIImageView()
        profileImage.image = #imageLiteral(resourceName: "icons8-user.png").withRenderingMode(.alwaysTemplate)
        profileImage.tintColor = .white
        //profileImage.backgroundColor = .green
        return profileImage
        
    }()
    
    public lazy var firstNameLabel: UITextField = {
        let firstNameLabel = UITextField()
        firstNameLabel.textColor = .white
         firstNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        firstNameLabel.textAlignment = .left
        firstNameLabel.isUserInteractionEnabled = false
        firstNameLabel.isEnabled = false
        //firstNameLabel.backgroundColor = .red
        return firstNameLabel
    }()
    
    public lazy var lastNameLabel: UITextField = {
        let lastNameLabel = UITextField()
        lastNameLabel.textColor = .white
        lastNameLabel.textAlignment = .left
        lastNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        lastNameLabel.isUserInteractionEnabled = true
        lastNameLabel.isEnabled = false 
        //lastNameLabel.backgroundColor = .red
        return lastNameLabel
    }()
    
    public lazy var boundaryView: UIView = {
        let boundaryView = UIView()
        boundaryView.backgroundColor = .orange
        return boundaryView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        setImageViewContrains()
        setFirstNameLabelConstrains()
        //setBoundaryViewContrains()
        setLastNameLabelConstrains()
     
        
    }
    
    private func setImageViewContrains(){
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    private func setFirstNameLabelConstrains(){
        addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        //firstNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        firstNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 25).isActive = true
        firstNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
       // firstNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //firstNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        //firstNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
//    private func setBoundaryViewContrains(){
//        addSubview(boundaryView)
//        boundaryView.translatesAutoresizingMaskIntoConstraints = false
//        boundaryView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
//        boundaryView.leadingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor, constant: 5).isActive = true
//        boundaryView.widthAnchor.constraint(equalToConstant: 1).isActive = true
//        boundaryView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
//
//    }
    
    
    private func setLastNameLabelConstrains(){
        addSubview(lastNameLabel)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 15).isActive = true
        lastNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 110).isActive = true
        lastNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        lastNameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: 15).isActive = true
        //firstNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //lastNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    

}
