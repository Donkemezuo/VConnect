//
//  BookMarkedTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/13/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class BookMarkedTableViewCell: UITableViewCell {
    
    public lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        return containerView
    }()
    
    private lazy var designView: UIView = {
        let designView = UIView()
      designView.backgroundColor = UIColor.init(hexString: "0072B1")
        designView.layer.cornerRadius = 2
        return designView
    }()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        contentView.frame.inset(by: margins)
    }
    
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
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 17
        containerView.layer.shadowOpacity = 0.9
        containerView.layer.borderColor = UIColor.init(hexString: "033860")?.cgColor
        containerView.layer.borderWidth = 1
    }
    
    
    private func setConstrains(){
        setContainerViewConstrains()
        setDesignViewConstrains()
        setNameLabelConstrains()
        setAddressLabelConstrains()
        setDateLabelConstrains()
      
        
    }
    
    private func setContainerViewConstrains(){
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        
    }
    
    private func setDesignViewConstrains(){
        containerView.addSubview(designView)
        designView.translatesAutoresizingMaskIntoConstraints = false
        designView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        designView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        designView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        designView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setNameLabelConstrains(){
        designView.addSubview(ngoName)
        ngoName.translatesAutoresizingMaskIntoConstraints = false
        ngoName.topAnchor.constraint(equalTo: designView.topAnchor, constant: 5).isActive = true
           ngoName.leadingAnchor.constraint(equalTo: designView.leadingAnchor, constant: 10).isActive = true
           ngoName.trailingAnchor.constraint(equalTo: designView.trailingAnchor, constant: -10).isActive = true
        ngoName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setAddressLabelConstrains(){
        designView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: ngoName.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: designView.leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: designView.trailingAnchor, constant: -10).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setDateLabelConstrains(){
        designView.addSubview(savedDate)
    savedDate.translatesAutoresizingMaskIntoConstraints = false
    savedDate.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
    savedDate.trailingAnchor.constraint(equalTo: designView.trailingAnchor, constant: -10).isActive = true
        savedDate.leadingAnchor.constraint(equalTo: designView.leadingAnchor, constant: 10).isActive = true
    savedDate.bottomAnchor.constraint(equalTo: designView.bottomAnchor, constant: -5).isActive = true
    }
    
    
    
    

}
