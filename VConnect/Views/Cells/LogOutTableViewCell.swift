//
//  LogOutTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class LogOutTableViewCell: UITableViewCell {
    
    public lazy var logOutButton: UIButton = {
        let logOutButton = UIButton()
        logOutButton.layer.cornerRadius = 20
        logOutButton.setTitle("Log Out", for: .normal)
        //logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        logOutButton.backgroundColor = UIColor.orange.withAlphaComponent(0.9)
        return logOutButton
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
    
    private func setConstrains(){
        
        addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
    }

    
}
