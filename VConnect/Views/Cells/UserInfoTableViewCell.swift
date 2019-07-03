//
//  UserInfoTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/16/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView?.contentMode = .scaleAspectFill
        userImageView?.layer.cornerRadius = bounds.width/2
        userImageView?.layer.borderColor = UIColor.lightGray.cgColor
        userImageView?.layer.borderWidth = 0.5
        userImageView?.clipsToBounds = true 
    }

}
