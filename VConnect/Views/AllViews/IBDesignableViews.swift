//
//  IBDesignableViews.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/30/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentMode = .scaleAspectFill
        layer.cornerRadius = bounds.width / 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        
    }
}

