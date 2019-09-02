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
    
    @IBOutlet weak var cancelButton: UIButton!
   
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!

    @IBOutlet weak var buttonBarView: UIView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var switchSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var editButton: UIButton!

    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true
        //profileImageView.isUserInteractionEnabled = false
    
    }
    
    private func setItemsLayout(){
        cancelButton.setImage(#imageLiteral(resourceName: "icons8-delete_sign_filled").withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.tintColor = .white
        cancelButton.isHidden = false
        fullNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
         fullNameLabel.textColor = .white
        emailLabel.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
         emailLabel.textColor = .white
        emailLabel.text = "Email Address"
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.orange, for: .normal)
        editButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        switchSegmentedControl.tintColor = .clear
        switchSegmentedControl.backgroundColor = .clear
        switchSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 18) ?? 0,
            NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .normal)
        
        
        switchSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 18) ?? 0,
            NSAttributedString.Key.foregroundColor: UIColor.orange
            ], for: .selected)
        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
       buttonBarView.backgroundColor = UIColor.orange
        buttonBarView.topAnchor.constraint(equalTo: switchSegmentedControl.bottomAnchor).isActive = true
        buttonBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        buttonBarView.leftAnchor.constraint(equalTo: switchSegmentedControl.leftAnchor).isActive = true
        buttonBarView.widthAnchor.constraint(equalTo: switchSegmentedControl.widthAnchor, multiplier: 1 / CGFloat(switchSegmentedControl.numberOfSegments)).isActive = true
        profileImageView.isUserInteractionEnabled = false 
        
    }
    
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
