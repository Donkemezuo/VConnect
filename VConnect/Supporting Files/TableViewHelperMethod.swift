//
//  TableViewHelperMethod.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class EmptyView {
    
    public static func emptyMessage(message: String, size: CGSize) -> UIView {
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        //messageLabel.backgroundColor = .white
    messageLabel.backgroundColor = UIColor.init(hexString: "0072B1")
        return messageLabel
    }
    
}
