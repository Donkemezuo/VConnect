//
//  DefaultBackgroundTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class DefaultBackgroundTableViewCell: UITableViewCell {
    
    public lazy var defaultImageView: UIImageView = {
        let defaultImageView = UIImageView()
        defaultImageView.backgroundColor = .red
        return defaultImageView
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
        addSubview(defaultImageView)
        defaultImageView.translatesAutoresizingMaskIntoConstraints = false 
        defaultImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        defaultImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        defaultImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        defaultImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    

}
