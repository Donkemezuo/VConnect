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
        addressLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        addressLabel.text = "Address"
        addressLabel.textColor = .white
        addressLabel.textAlignment = .left
        return addressLabel
    }()

    public lazy var contactLabel: UILabel = {
        let contactLabel = UILabel()
        contactLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        contactLabel.text = "Contact"
        contactLabel.textColor = .white
        contactLabel.textAlignment = .left
        return contactLabel
    }()
    
    public lazy var hoursLabel: UILabel = {
        let hoursLabel = UILabel()
        hoursLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        hoursLabel.text = "Hours"
        hoursLabel.textColor = .white
        hoursLabel.textAlignment = .center
        return hoursLabel
    }()

    public lazy var addressTextView: UITextView = {
        let addressTextView = UITextView()
        addressTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        addressTextView.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        addressTextView.textAlignment = .left
        addressTextView.isEditable = false
        addressTextView.isSelectable = false
        addressTextView.dataDetectorTypes = UIDataDetectorTypes.address
        addressTextView.backgroundColor = .clear
        addressTextView.isScrollEnabled =  false
        return addressTextView
    }()


    public lazy var contactInfoTextView: UITextView = {
        let contactInfoTextView = UITextView()
        contactInfoTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        contactInfoTextView.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        contactInfoTextView.isEditable = false
        contactInfoTextView.isSelectable = false
        contactInfoTextView.textAlignment = .left
        contactInfoTextView.backgroundColor = .clear
        contactInfoTextView.isScrollEnabled =  false
        return contactInfoTextView
    }()



    public lazy var operationalHoursTextView: UITextView = {
        let operationalHoursTextView = UITextView()
        operationalHoursTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        operationalHoursTextView.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        //operationalHoursTextView.textAlignment = .left
        operationalHoursTextView.backgroundColor = .clear
        operationalHoursTextView.isScrollEnabled =  false
        operationalHoursTextView.textAlignment = .left
        operationalHoursTextView.isEditable =  false
        operationalHoursTextView.isScrollEnabled = false 
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
      setHoursLabelConstrains()
      setAddressTextViewConstrains()
      setContactsLabelContrains()
      setContactTextViewConstrains()
      setHoursTextViewConstrains()
        
    }
    
    private func setAddressLabelContrains(){
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    private func setHoursLabelConstrains(){
        addSubview(hoursLabel)
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        hoursLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 10).isActive = true
        hoursLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    private func setAddressTextViewConstrains(){
        addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        addressTextView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor).isActive = true
        addressTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        addressTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addressTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setContactsLabelContrains(){
        addSubview(contactLabel)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.topAnchor.constraint(equalTo: addressTextView.bottomAnchor, constant: 5).isActive = true
        contactLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        contactLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
   
    }
    private func setContactTextViewConstrains(){
        addSubview(contactInfoTextView)
        contactInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        contactInfoTextView.topAnchor.constraint(equalTo: contactLabel.bottomAnchor).isActive = true
        contactInfoTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        contactInfoTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        contactInfoTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setHoursTextViewConstrains(){
        addSubview(operationalHoursTextView)
        operationalHoursTextView.translatesAutoresizingMaskIntoConstraints = false
        operationalHoursTextView.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor).isActive = true
        operationalHoursTextView.leadingAnchor.constraint(equalTo: addressTextView.trailingAnchor, constant: 30).isActive = true
        operationalHoursTextView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        operationalHoursTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    
}
