//
//  HoursAndAddressView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/1/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class HoursAndAddressView: UIView {
    
    public lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        //contentView.clipsToBounds = true
        
        
        return contentView
    }()
    
    public lazy var googleMapView: UIView = {
        let googleMapView = UIView()
        googleMapView.backgroundColor = .lightGray
        googleMapView.layer.cornerRadius = 5
        return googleMapView
    }()
    
    public lazy var addressTxtView: UITextView = {
        let addressTxtView = UITextView()
        addressTxtView.textColor = UIColor.init(hexString: "033860")
        addressTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        addressTxtView.isEditable = false
        addressTxtView.isSelectable = false
        addressTxtView.dataDetectorTypes = [.address]
        addressTxtView.isScrollEnabled = false
        return addressTxtView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
        setContentViewConstrains()
        setGoogleMapConstrains()
        setAddressTxtViewConstrains()
    }
    
    private func setContentViewConstrains(){
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func setGoogleMapConstrains(){
        contentView.addSubview(googleMapView)
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        googleMapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        googleMapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        googleMapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        //googleMapView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setAddressTxtViewConstrains(){
        contentView.addSubview(addressTxtView)
        addressTxtView.translatesAutoresizingMaskIntoConstraints = false
        addressTxtView.topAnchor.constraint(equalTo: googleMapView.bottomAnchor, constant: 2).isActive = true
        addressTxtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        addressTxtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        addressTxtView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    
    
    
    
}
