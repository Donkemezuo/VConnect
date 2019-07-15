//
//  GoogleMapViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class GoogleMapViewController: UIViewController {
    
    let googleMapView = GoogleMapView()
    var vConnectUserLocationCoordinates: CLLocationCoordinate2D!
    private var geoCoder: CLGeocoder!
    var nGO: NGO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(googleMapView)
        view.backgroundColor = UIColor.init(hexString: "0072B1")
        dismissMapView()
        print(vConnectUserLocationCoordinates)
        //getUserAddress()
    }
    
    private func dismissMapView(){
        googleMapView.cancelButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    @objc private func dismissButtonPressed(){
     navigationController?.popViewController(animated: true)

    }
    
    private func getUserAddress(){
        let location = CLLocation(latitude: vConnectUserLocationCoordinates.latitude, longitude: vConnectUserLocationCoordinates.longitude)
        print(location)
        
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let placemark = placemark?.first {
                
                if let locality = placemark.locality {
                    print(locality)
                    
                    self.drawRoutingLines(fromOriginAtUserLocation:locality, toNGOLocation: self.nGO.fullAddress)
                }
                
            }
            
        }
        
    }
    
    private func drawRoutingLines(fromOriginAtUserLocation origin: String, toNGOLocation destination: String) {
        let directionsURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(SecretKeys.googleAddressesAPIKey)"
        guard let endPointURL = URL(string: directionsURL) else {return}
        
        Alamofire.request(endPointURL).responseJSON { (response) in
            let json = response.result.value as! NSDictionary
            let routes = json["routes"] as! NSArray
            
            for route in routes {
                let values = route as! NSDictionary
                
                let routesOverViewPolyline = values["overview_polyline"] as! NSDictionary
                let points = routesOverViewPolyline["points"] as! String
                let path = GMSPath(fromEncodedPath: points)
                
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .black
                polyline.strokeWidth = 4
                polyline.map = self.googleMapView.googleMapView
            }
            
        }
        
        //let request = URLRequest(url:endPointURL)
        
        
        
        
        
    }
    
    
}
