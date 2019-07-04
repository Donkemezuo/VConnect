//
//  UserInfoTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/16/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView?.contentMode = .scaleAspectFill
        userImageView?.layer.cornerRadius = (userImageView?.frame.size.width)!/2
         userImageView.layer.masksToBounds = false
        userImageView?.layer.borderColor = UIColor.lightGray.cgColor
        userImageView?.layer.borderWidth = 1
        userImageView?.clipsToBounds = true
        
      
    }

}
