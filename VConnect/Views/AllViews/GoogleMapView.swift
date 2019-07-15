//
//  GoogleMapView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import GoogleMaps


class GoogleMapView: UIView {

    public lazy var containerView: UIView = {
        let containView = UIView()
        //containView.backgroundColor = UIColor.init(hexString: "2E294E")
        containView.backgroundColor = UIColor.init(hexString: "0072B1")
        return containView
        
    }()
    
    public lazy var mapViewLabel: UILabel = {
        let mapViewLabel = UILabel()
        mapViewLabel.text = "Route"
        mapViewLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        mapViewLabel.textColor = .white 
        return mapViewLabel
    }()
    
    public lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "icons8-delete_sign_filled.png").withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.tintColor = .white
        return cancelButton
    }()
    
    public lazy var googleMapView: GMSMapView = {
        let googleMapView = GMSMapView()
        googleMapView.backgroundColor = .white
        googleMapView.layer.cornerRadius = 5
        return googleMapView
        
    }()
    
    public lazy var designView: UIView = {
        let designView = UIView()
        designView.backgroundColor = UIColor.init(hexString: "0072B1")
        return designView
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
        setContainerViewConstrains()
        setMapViewLabel()
        setCancelButtonConstrains()
        setGoogleMapViewConstrains()
        setDesignConstrains()
    }
    
    private func setContainerViewConstrains(){
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    private func setMapViewLabel(){
        containerView.addSubview(mapViewLabel)
        mapViewLabel.translatesAutoresizingMaskIntoConstraints = false
        mapViewLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25).isActive = true
        mapViewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        mapViewLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        mapViewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setCancelButtonConstrains(){
        //addSubview(cancelButton)
        containerView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 350).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    private func setGoogleMapViewConstrains(){
        addSubview(googleMapView)
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        googleMapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        googleMapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        googleMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    private func setDesignConstrains(){
        addSubview(designView)
        designView.translatesAutoresizingMaskIntoConstraints = false
        designView.topAnchor.constraint(equalTo: googleMapView.bottomAnchor).isActive = true
        designView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        designView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        designView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    

    
    
  

}
