//
//  EmailTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    public lazy var profileImage: UIImageView = {
        
        let emailIconImageView = UIImageView()
        emailIconImageView.image = #imageLiteral(resourceName: "icons8-new_post.png").withRenderingMode(.alwaysTemplate)
        emailIconImageView.tintColor = .white
        return emailIconImageView
        
    }()
    
    public lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.textColor = .white
        emailLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        emailLabel.textAlignment = .left
        return emailLabel
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
        setImageViewContrains()
        setEmailLabelConstrains()
        
    }
    
    private func setImageViewContrains(){
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    private func setEmailLabelConstrains(){
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        //emailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 25).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        //emailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }

}
