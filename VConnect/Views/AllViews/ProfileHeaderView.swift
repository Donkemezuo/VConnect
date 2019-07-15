//
//  ProfileHeaderView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/27/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit


class ProfileHeaderView: UIView {
    
    @IBOutlet weak var ProfileHeaderViewContainer: UIView!
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
   
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTxtField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
 
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var bookMarksLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true
    }
    
    private func setItemsLayout(){
        cancelButton.setImage(#imageLiteral(resourceName: "icons8-delete_sign_filled.png").withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.tintColor = .white
        firstNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
         firstNameLabel.textColor = .white
        firstNameLabel.text = "First Name"
        firstNameTxtField.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
         firstNameTxtField.textColor = .white
        firstNameTxtField.backgroundColor = .clear
        lastNameLabel.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
         lastNameLabel.textColor = .white
        lastNameLabel.text = "Last Name"
         lastNameTxtField.textColor = .white
        lastNameTxtField.backgroundColor = .clear
        lastNameTxtField.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
         lastNameTxtField.textColor = .white
        emailLabel.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
         emailLabel.textColor = .white
        emailLabel.text = "Email Address"
        emailTxtField.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
        emailTxtField.textColor = .white
        emailTxtField.backgroundColor = .clear
        bookMarksLabel.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
        bookMarksLabel.text = "BookMarks"
         bookMarksLabel.textColor = .white
    }
    
    
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        reviewerProfileImage.contentMode = .scaleAspectFill
//        reviewerProfileImage.layer.cornerRadius = reviewerProfileImage.frame.size.width/2
//        reviewerProfileImage.layer.masksToBounds = false
//        reviewerProfileImage.layer.borderColor = UIColor.lightGray.cgColor
//        reviewerProfileImage.layer.borderWidth = 1
//        reviewerProfileImage.clipsToBounds = true
//    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setItemsLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        addSubview(ProfileHeaderViewContainer)
        ProfileHeaderViewContainer.frame = bounds
    }
    
 
    
    
}
