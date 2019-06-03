//
//  HoursAndAddressView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/1/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class HoursAndAddressView: UIView {
    
    public lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        addressLabel.text = "Address"
        addressLabel.textColor = .white
        return addressLabel
    }()

    public lazy var contactLabel: UILabel = {
        let contactLabel = UILabel()
        contactLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        contactLabel.text = "Contact"
        contactLabel.textColor = .white
        contactLabel.textAlignment = .left
        return contactLabel
    }()
    
    public lazy var hoursLabel: UILabel = {
        let hoursLabel = UILabel()
        hoursLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        hoursLabel.text = "Hours"
        hoursLabel.textColor = .white
        return hoursLabel
    }()

    public lazy var addressTextView: UITextView = {
        let addressTextView = UITextView()
        addressTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        addressTextView.textColor = .white
        addressTextView.textAlignment = .left
        addressTextView.isEditable = false
        addressTextView.isSelectable = false
        addressTextView.dataDetectorTypes = UIDataDetectorTypes.address
        addressTextView.backgroundColor = .clear
        return addressTextView
    }()


    public lazy var contactInfoTextView: UITextView = {
        let contactInfoTextView = UITextView()
        contactInfoTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        contactInfoTextView.textColor = .white
        contactInfoTextView.isEditable = false
        contactInfoTextView.isSelectable = false
        contactInfoTextView.textAlignment = .left
        contactInfoTextView.backgroundColor = .clear
        return contactInfoTextView
    }()



    public lazy var operationalHoursTextView: UITextView = {
        let operationalHoursTextView = UITextView()
        operationalHoursTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        operationalHoursTextView.textColor = .white
        operationalHoursTextView.textAlignment = .left
        operationalHoursTextView.backgroundColor = .clear
        return operationalHoursTextView
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
        setupConstrains()
    }
    
    
    private func setupConstrains(){
        setAddressLabelContrains()
        setContactsLabelContrains()
        setHoursLabelConstrains()
        setAddressTextViewConstrains()
        setContactTextViewConstrains()
        setHoursTextViewConstrains()
        
    }
    
    private func setAddressLabelContrains(){
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -260).isActive = true
    }
    
    private func setContactsLabelContrains(){
        addSubview(contactLabel)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        contactLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 10).isActive = true
        contactLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -115).isActive = true
    }
    
    private func setHoursLabelConstrains(){
        addSubview(hoursLabel)
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        hoursLabel.leadingAnchor.constraint(equalTo: contactLabel.trailingAnchor, constant: 0).isActive = true
        hoursLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setAddressTextViewConstrains(){
        addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        addressTextView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor).isActive = true
        addressTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        addressTextView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        addressTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setContactTextViewConstrains(){
        addSubview(contactInfoTextView)
        contactInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        contactInfoTextView.topAnchor.constraint(equalTo: contactLabel.bottomAnchor).isActive = true
        contactInfoTextView.leadingAnchor.constraint(equalTo: addressTextView.trailingAnchor).isActive = true
        contactInfoTextView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        contactInfoTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setHoursTextViewConstrains(){
        addSubview(operationalHoursTextView)
        operationalHoursTextView.translatesAutoresizingMaskIntoConstraints = false
        operationalHoursTextView.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor).isActive = true
        operationalHoursTextView.leadingAnchor.constraint(equalTo: contactInfoTextView.trailingAnchor, constant: 5).isActive = true
        operationalHoursTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        operationalHoursTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    
}
