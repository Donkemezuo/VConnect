//
//  GoogleMapViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class GoogleMapViewController: UIViewController {
    
    let googleMapView = GoogleMapView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(googleMapView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        
    }

}
