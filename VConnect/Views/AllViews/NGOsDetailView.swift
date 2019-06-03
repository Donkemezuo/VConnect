//
//  NGOsDetailView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/31/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsDetailView: UIView {

    public lazy var nGONameLabel: UILabel = {
        let nGONameLabel = UILabel()
        nGONameLabel.textColor = .white
        nGONameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        nGONameLabel.textAlignment = .center
        nGONameLabel.numberOfLines = 0
        return nGONameLabel
    }()
    
    public lazy var nGODescription: UITextView = {
        let nGODescription = UITextView()
        nGODescription.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        nGODescription.textColor = .white
        nGODescription.textAlignment = .center
        nGODescription.backgroundColor = .clear
        nGODescription.isEditable = false
        nGODescription.isSelectable = false
        return nGODescription
    }()
    
    public lazy var nGOWebsite: UITextView = {
        let website = UITextView()
        website.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        website.textColor = .white
        //website.textAlignment = .left
        website.backgroundColor = .clear
        website.isEditable = false
        website.isSelectable = false
        website.dataDetectorTypes = UIDataDetectorTypes.link
        return website
    }()
    
    
    public lazy var viewsSegmentedControl: UISegmentedControl = {
        let viewsSegmentedControl = UISegmentedControl()
        viewsSegmentedControl.insertSegment(withTitle: "Photos", at: 0, animated: true)
        viewsSegmentedControl.insertSegment(withTitle: "Address and Hours", at: 1, animated: true)
        viewsSegmentedControl.insertSegment(withTitle: "Reviews", at: 2, animated: true)
        viewsSegmentedControl.selectedSegmentIndex = 0
        viewsSegmentedControl.tintColor = .white
        
        return viewsSegmentedControl
        
    }()
    
    public lazy var toggledView: UIView = {
        let toggledView = UIView()
        return toggledView
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
        setNameConstrains()
        setDescriptionConstrains()
        setNGOWebsiteTextViewConstrains()
        setViewsSegmentedControlConstrains()
        setToggledViewConstrains()
        
    }
    
    private func setNameConstrains(){
        addSubview(nGONameLabel)
        nGONameLabel.translatesAutoresizingMaskIntoConstraints = false
        nGONameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        nGONameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        nGONameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setDescriptionConstrains(){
        addSubview(nGODescription)
        nGODescription.translatesAutoresizingMaskIntoConstraints = false
        nGODescription.topAnchor.constraint(equalTo: nGONameLabel.bottomAnchor, constant: 5).isActive = true
        nGODescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        nGODescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        nGODescription.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    private func setNGOWebsiteTextViewConstrains(){
        addSubview(nGOWebsite)
        nGOWebsite.translatesAutoresizingMaskIntoConstraints = false
        nGOWebsite.topAnchor.constraint(equalTo: nGODescription.bottomAnchor, constant: 5).isActive = true
        nGOWebsite.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nGOWebsite.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        nGOWebsite.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setViewsSegmentedControlConstrains(){
        addSubview(viewsSegmentedControl)
        viewsSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        viewsSegmentedControl.topAnchor.constraint(equalTo: nGOWebsite.bottomAnchor, constant: 5).isActive = true
        viewsSegmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        viewsSegmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        viewsSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setToggledViewConstrains(){
        addSubview(toggledView)
        toggledView.translatesAutoresizingMaskIntoConstraints = false 
        toggledView.topAnchor.constraint(equalTo: viewsSegmentedControl.bottomAnchor, constant: 2).isActive = true
        toggledView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        toggledView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        toggledView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    

}
