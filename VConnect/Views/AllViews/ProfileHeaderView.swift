//
//  ProfileHeaderView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/27/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    
    func moreOptionsButton(_ profileHeaderView: ProfileHeaderView)
}

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var ProfileHeaderViewContainer: UIView!
    
    @IBOutlet weak var moreOptionsButton: UIButton!
    
    @IBOutlet weak var vConnectUserProfileImageView: CircularImageView!
    
    @IBOutlet weak var vConnectUserNameLabel: UILabel!
    
    @IBOutlet weak var vConnectUserEmailLabel: UILabel!
    
    @IBOutlet weak var vConnectUserLocationLabel: UILabel!
    
    @IBOutlet weak var profileSettingsSegmentedControl: UISegmentedControl!
    
    
    
    weak var delegate: ProfileHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
    
    
    @IBAction func moreOptionsButtonPressed(_ sender: UIButton) {
        delegate?.moreOptionsButton(self)
        
    }
    
    
}
