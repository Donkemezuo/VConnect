//
//  HoursAndAddressView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/1/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import GoogleMaps

class HoursAndAddressView: UIView {
    
    public lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        //contentView.clipsToBounds = true
        
        
        return contentView
    }()
    
    public lazy var operationalHoursLabel: UILabel = {
        let operationalHoursLabel = UILabel()
       operationalHoursLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
       operationalHoursLabel.text = "Hours of Operation"
       operationalHoursLabel.textColor = UIColor.init(hexString: "0072B1")
        operationalHoursLabel.textAlignment = .center
        return operationalHoursLabel
    }()
    
    
    public lazy var googleMapView: GMSMapView = {
        let googleMapView = GMSMapView()
        googleMapView.backgroundColor = .lightGray
        googleMapView.layer.cornerRadius = 5
        return googleMapView
    }()
    
    public lazy var operationalHoursTxtView: UITextView = {
        let operationalHoursTxtView = UITextView()
        operationalHoursTxtView.textColor = UIColor.init(hexString: "0072B1")
        operationalHoursTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        operationalHoursTxtView.isEditable = false
        operationalHoursTxtView.isSelectable = false
        operationalHoursTxtView.backgroundColor = .clear
        operationalHoursTxtView.textAlignment = .center
        return operationalHoursTxtView
    }()
    
    public lazy var addressTxtView: UITextView = {
        let addressTxtView = UITextView()
        addressTxtView.textColor = UIColor.init(hexString: "0072B1")
        addressTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        addressTxtView.isEditable = false
        addressTxtView.isSelectable = false
        addressTxtView.dataDetectorTypes = [.address]
        //addressTxtView.isScrollEnabled = false
        addressTxtView.backgroundColor = .clear 
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
        setLabelConstrains()
        setoperationalHoursTxtViewConstrains()
        setAddressTxtViewConstrains()
    }
    
    private func setContentViewConstrains(){
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    private func setGoogleMapConstrains(){
        contentView.addSubview(googleMapView)
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        googleMapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        googleMapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18).isActive = true
        googleMapView.heightAnchor.constraint(equalToConstant: 290).isActive = true
    }
    
    private func setLabelConstrains(){
        contentView.addSubview(operationalHoursLabel)
        operationalHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        operationalHoursLabel.topAnchor.constraint(equalTo: googleMapView.bottomAnchor, constant: 10).isActive = true
        operationalHoursLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        operationalHoursLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        operationalHoursLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setoperationalHoursTxtViewConstrains(){
        contentView.addSubview(operationalHoursTxtView)
        operationalHoursTxtView.translatesAutoresizingMaskIntoConstraints = false
        operationalHoursTxtView.topAnchor.constraint(equalTo: operationalHoursLabel.bottomAnchor, constant: 5).isActive = true
        operationalHoursTxtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        operationalHoursTxtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        operationalHoursTxtView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setAddressTxtViewConstrains(){
        googleMapView.addSubview(addressTxtView)
        addressTxtView.translatesAutoresizingMaskIntoConstraints = false
        addressTxtView.topAnchor.constraint(equalTo: googleMapView.topAnchor, constant: 235).isActive = true
        addressTxtView.leadingAnchor.constraint(equalTo: googleMapView.leadingAnchor, constant: 140).isActive = true
        addressTxtView.trailingAnchor.constraint(equalTo: googleMapView.trailingAnchor).isActive = true
        addressTxtView.bottomAnchor.constraint(equalTo: googleMapView.bottomAnchor).isActive = true
    }
    
    
    
    
    
    
}
