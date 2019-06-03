//
//  NGOsMapView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import MapKit

class NGOsMapView: UIView {
    
    public lazy var mapView:MKMapView = {
        let mapView = MKMapView()
        return mapView
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
       setMapViewConstrains()
        
    }
    
    private func setMapViewConstrains(){
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
         mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
         mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
         mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
