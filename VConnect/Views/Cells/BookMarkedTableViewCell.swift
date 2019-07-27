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
        savedDate.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 14)
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
        setAddressLabelConstrains()
        setDateLabelConstrains()
      
        
    }
    
    private func setNameLabelConstrains(){
        addSubview(ngoName)
        ngoName.translatesAutoresizingMaskIntoConstraints = false
        ngoName.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
           ngoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
           ngoName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        ngoName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setAddressLabelConstrains(){
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: ngoName.bottomAnchor, constant: 15).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setDateLabelConstrains(){
        addSubview(savedDate)
    savedDate.translatesAutoresizingMaskIntoConstraints = false
    savedDate.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15).isActive = true
    savedDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        savedDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    savedDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    
    
    

}
