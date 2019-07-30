//
//  NGOMissionView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOMissionView: UIView {
    
    public lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        //contentView.clipsToBounds = true 
        
        
        return contentView
    }()

    public lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
         descriptionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = UIColor.init(hexString: "0072B1")
        descriptionLabel.backgroundColor = .clear
        return descriptionLabel
    }()
    
    public lazy var ngoDescriptionTxtView: UITextView = {
        let ngoDescriptionTxtView = UITextView()
        ngoDescriptionTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        ngoDescriptionTxtView.textColor = UIColor.init(hexString: "0072B1")
        //ngoDescriptionTxtView.textColor = .black
        ngoDescriptionTxtView.backgroundColor = .clear
        return ngoDescriptionTxtView
    }()
    
    public lazy var missionLabel: UILabel = {
        let missionLabel = UILabel()
        missionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        missionLabel.text = "Mission"
        missionLabel.textColor = UIColor.init(hexString: "0072B1")
        missionLabel.backgroundColor = .clear
        return missionLabel
    }()
    
    public lazy var websiteTxtView: UITextView  = {
        let websiteTxtView = UITextView()
        websiteTxtView.dataDetectorTypes = [.link]
        //websiteTxtView.textColor = .white
        websiteTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        //websiteTxtView.textColor = UIColor.init(hexString: "0072B1")
        websiteTxtView.textAlignment = .center
        websiteTxtView.isEditable = false
       // websiteTxtView.tintColor = UIColor.init(hexString: "0072B1")
        return websiteTxtView
        
        }()
    
    public lazy var ngoMissionTxtView: UITextView = {
        let ngoMissionTxtView = UITextView()
        ngoMissionTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        ngoMissionTxtView.textColor = UIColor.init(hexString: "0072B1")
        ngoMissionTxtView.backgroundColor = .clear
        return ngoMissionTxtView
    }()
    
    public lazy var visionLabel: UILabel = {
        let visionLabel = UILabel()
        visionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        visionLabel.text = "Vision"
        visionLabel.textColor = UIColor.init(hexString: "0072B1")
        visionLabel.backgroundColor = .clear
        return visionLabel
    }()
    
    public lazy var ngoVissionTxtView: UITextView = {
        let ngoVissionTxtView = UITextView()
        ngoVissionTxtView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        ngoVissionTxtView.textColor = UIColor.init(hexString: "0072B1")
        ngoVissionTxtView.backgroundColor = .clear
        return ngoVissionTxtView
    }()
    
    public lazy var contactPersonLabel: UILabel = {
        let contactPersonLabel = UILabel()
        contactPersonLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        contactPersonLabel.text = "Contact Person"
        contactPersonLabel.textColor = UIColor.init(hexString: "0072B1")
        return contactPersonLabel
    }()
    
    public lazy var contactPersonNameLabel: UILabel = {
        let contactPersonNameLabel = UILabel()
        contactPersonNameLabel.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 13)
        //contactPersonNameLabel.text = "Contact Person"
        contactPersonNameLabel.textColor = UIColor.init(hexString: "0072B1")
        return contactPersonNameLabel
    }()
    //public lazy var ngoObjectives: UITextView = {}
    
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
        setDescriptionLabelConstrains()
        ngoDescriptionTxtViewConstrains()
        ngoWebsiteTxtView()
        missionLabelConstrains()
        ngoMissionTxtViewConstrains()
        setVisionLabelConstrains()
        ngoVisionStatementTxtViewConstrains()
        setContactPersonLabel()
        setContactPersonNameLabel()
     
    }
    
    private func setContentViewConstrains(){
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    private func setDescriptionLabelConstrains(){
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func ngoDescriptionTxtViewConstrains(){
        contentView.addSubview(ngoDescriptionTxtView)
        ngoDescriptionTxtView.translatesAutoresizingMaskIntoConstraints = false
        ngoDescriptionTxtView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        ngoDescriptionTxtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        ngoDescriptionTxtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        ngoDescriptionTxtView.heightAnchor.constraint(equalToConstant: 245).isActive = true
    }
    
    private func ngoWebsiteTxtView(){
        contentView.addSubview(websiteTxtView)
        websiteTxtView.translatesAutoresizingMaskIntoConstraints = false
        websiteTxtView.topAnchor.constraint(equalTo: ngoDescriptionTxtView.bottomAnchor).isActive = true
        websiteTxtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        websiteTxtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        websiteTxtView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func missionLabelConstrains(){
        contentView.addSubview(missionLabel)
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.topAnchor.constraint(equalTo: websiteTxtView.bottomAnchor, constant: 10).isActive = true
       
        missionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        missionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        missionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    
    private func ngoMissionTxtViewConstrains(){
        contentView.addSubview(ngoMissionTxtView)
        ngoMissionTxtView.translatesAutoresizingMaskIntoConstraints = false
        ngoMissionTxtView.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 10).isActive = true
        ngoMissionTxtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        //ngoMissionTxtView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ngoMissionTxtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        ngoMissionTxtView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    private func setVisionLabelConstrains(){
        contentView.addSubview(visionLabel)
        visionLabel.translatesAutoresizingMaskIntoConstraints = false
        visionLabel.topAnchor.constraint(equalTo: ngoMissionTxtView.bottomAnchor, constant: 10).isActive = true
        visionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        visionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        visionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    private func ngoVisionStatementTxtViewConstrains(){
        contentView.addSubview(ngoVissionTxtView)
        ngoVissionTxtView.translatesAutoresizingMaskIntoConstraints = false
        ngoVissionTxtView.topAnchor.constraint(equalTo: visionLabel.bottomAnchor, constant: 10).isActive = true
        ngoVissionTxtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        ngoVissionTxtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        ngoVissionTxtView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    private func setContactPersonLabel(){
        contentView.addSubview(contactPersonLabel)
        contactPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        contactPersonLabel.topAnchor.constraint(equalTo: ngoVissionTxtView.bottomAnchor, constant: 10).isActive = true
        contactPersonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        contactPersonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        contactPersonLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setContactPersonNameLabel(){
        contentView.addSubview(contactPersonNameLabel)
        contactPersonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactPersonNameLabel.topAnchor.constraint(equalTo: contactPersonLabel.bottomAnchor, constant: 0).isActive = true
        contactPersonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        contactPersonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        contactPersonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
  
}
