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
    
    @IBOutlet weak var vConnectUserProfileImageView: UIImageView!
    
    @IBOutlet weak var vConnectUserNameLabel: UILabel!
    
    @IBOutlet weak var vConnectUserEmailLabel: UILabel!
    
    @IBOutlet weak var vConnectUserLocationLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vConnectUserProfileImageView.contentMode = .scaleAspectFill
        vConnectUserProfileImageView.layer.cornerRadius = vConnectUserProfileImageView.frame.size.width/2
        vConnectUserProfileImageView.layer.masksToBounds = false
        vConnectUserProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
        vConnectUserProfileImageView.layer.borderWidth = 1
        vConnectUserProfileImageView.clipsToBounds = true
        
        
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
