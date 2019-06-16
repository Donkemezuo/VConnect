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
    
    @IBOutlet weak var vConnectUserProfileImageView: CircularImageView!
    
    @IBOutlet weak var vConnectUserNameLabel: UILabel!
    
    @IBOutlet weak var vConnectUserEmailLabel: UILabel!
    
    @IBOutlet weak var vConnectUserLocationLabel: UILabel!
    
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
