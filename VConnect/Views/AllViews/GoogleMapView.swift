//
//  GoogleMapView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit


class GoogleMapView: UIView {

    public lazy var containerView: UIView = {
        let containView = UIView()
        //containView.backgroundColor = UIColor.init(hexString: "2E294E")
        containView.backgroundColor = UIColor.init(hexString: "033860")
        return containView
        
    }()
    
    public lazy var googleMapView: UIView = {
        let googleMapView = UIView()
        googleMapView.backgroundColor = .white
        //googleMapView
        
        return googleMapView
        
    }()
    
    public lazy var designView: UIView = {
        let designView = UIView()
        designView.backgroundColor = UIColor.init(hexString: "033860")
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
    
    private func setGoogleMapViewConstrains(){
        addSubview(googleMapView)
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        googleMapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        googleMapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        googleMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    private func setDesignConstrains(){
        addSubview(designView)
        designView.translatesAutoresizingMaskIntoConstraints = false
        designView.topAnchor.constraint(equalTo: googleMapView.bottomAnchor).isActive = true
        designView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        designView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        designView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    

    
    
  

}
