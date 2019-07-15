//
//  BookMarkedTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/13/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class BookMarkedTableViewCell: UITableViewCell {
    
    public lazy var ngoName: UILabel = {
        let ngoName = UILabel()
        ngoName.numberOfLines = 0
        ngoName.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        ngoName.textColor = .white
        
        
        return ngoName
    }()
    
    public lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        addressLabel.textColor = .white
        return addressLabel
    }()
    
    public lazy var savedDate: UILabel = {
        let savedDate = UILabel()
        savedDate.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        savedDate.textColor = .white
        return savedDate
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
        setNameLabelConstrains()
        setDateLabelConstrains()
        setAddressLabelConstrains()
        
    }
    
    private func setNameLabelConstrains(){
        addSubview(ngoName)
        ngoName.translatesAutoresizingMaskIntoConstraints = false
        ngoName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
           ngoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
           ngoName.widthAnchor.constraint(equalToConstant: 300).isActive = true
        ngoName.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setDateLabelConstrains(){
        addSubview(savedDate)
        savedDate.translatesAutoresizingMaskIntoConstraints = false
        savedDate.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        savedDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        savedDate.leadingAnchor.constraint(equalTo: ngoName.trailingAnchor, constant: 20).isActive = true
        savedDate.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setAddressLabelConstrains(){
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: ngoName.bottomAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        
    }
    
    
    
    

}
