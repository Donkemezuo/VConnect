//
//  NGOsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NGOsViewController: UIViewController {
    
    let nGOsView = NGOsView()
    let nGOsTableView = NGOsTableView()
    let nGOsMapView = NGOsMapView()
    private var geoCoder = CLGeocoder()
    private var annotations = [MKAnnotation]()
    //private var coordinates: CLLocationCoordinate2D!
    var locations: CLLocation!
    var coordinates = CLLocationCoordinate2D()
    
    private var allNGOsInCategory = [NGO](){
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
    
    private var vConnectUserSearchedNGOsInCategory = [NGO](){
        
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
    
    
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        navigationItem.title = "NGOs"
        nGOsTableView.nGOsTableView.delegate =  self
        nGOsTableView.nGOsTableView.dataSource = self
        nGOsView.searchBar.delegate = self
        setupSegmentedControl()
        nGOsView.resourcesView.addSubview(nGOsTableView)
        nGOsView.toggleView.tintColor = .white
        makeAnnotations(with: coordinates)
    }
    
    init(nGOsInCategory: [NGO]){
        super.init(nibName: nil, bundle: nil)
        self.allNGOsInCategory = nGOsInCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func setupSegmentedControl(){
        nGOsView.toggleView.addTarget(self, action: #selector(switchONViews), for: .valueChanged)
    }
    
    @objc private func switchONViews(){
        switch nGOsView.toggleView.selectedSegmentIndex {
        case 0:
            nGOsView.resourcesView.addSubview(nGOsTableView)
        case 1:
            nGOsView.resourcesView.addSubview(nGOsMapView)
        default:
            return
            
        }
    }
    
    private func generateCordinates(with NGOaddress: String) -> CLLocationCoordinate2D {
        
        geoCoder.geocodeAddressString(NGOaddress) { (placemarks, error) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else if let placemark = placemarks?.first {
                guard let location = placemark.location else {return}
 
                self.coordinates = location.coordinate
                print("Lat: \(self.coordinates.latitude)", "Long: \(self.coordinates.longitude)")
               // self.testZipCode(with: self.locations)
            }
        }
        
        return coordinates
    }
    
    
    private func makeAnnotations(with Coordinate:CLLocationCoordinate2D ) {
    nGOsMapView.mapView.removeAnnotations(annotations)
        for ngo in allNGOsInCategory {
            let ngOCordinates = generateCordinates(with: ngo.ngoCity)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2DMake(ngOCordinates.latitude, ngOCordinates.longitude)
            let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            nGOsMapView.mapView.setRegion(region, animated: true)
            annotation.title = ngo.ngoName
            annotation.subtitle = ngo.fullAddress
          
            //annotation.coordinate =
            annotations.append(annotation)
        }
        nGOsMapView.mapView.addAnnotations(annotations)
        nGOsMapView.mapView.showAnnotations(annotations, animated: true)
        
        
        
    }

    
    

    private func testZipCode(with location:CLLocation) {
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let placemark = placemarks?.first {
                print(placemark.postalCode ?? "no locality")
            }
        }

    }
}


extension NGOsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        nGOsView.searchBar.resignFirstResponder()
        
        vConnectUserSearchedNGOsInCategory = allNGOsInCategory.filter{$0.ngoCity == nGOsView.searchBar.text}
        nGOsTableView.nGOsTableView.reloadData()
        
        if nGOsView.searchBar.text == "" {
            isSearching = false
        nGOsTableView.nGOsTableView.reloadData()
        
        }

        
    }
    
}
extension NGOsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? vConnectUserSearchedNGOsInCategory.count : allNGOsInCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nGOsCell = tableView.dequeueReusableCell(withIdentifier: "NGOsTableViewCell", for: indexPath) as? NGOsTableViewCell else {return UITableViewCell()}
        
        let nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOsInCategory[indexPath.row]
        
   nGOsCell.nGOName.text = nGOToSet.ngoName
   nGOsCell.nGOCity.text = nGOToSet.ngoCity
    
    nGOsCell.backgroundColor = .clear
    nGOsCell.layer.borderWidth = 2
    nGOsCell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    nGOsCell.layer.cornerRadius = 5
    generateCordinates(with: nGOToSet.ngoCity)
        
    
        return nGOsCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOsInCategory[indexPath.row]
        let nGODetailViewController = NGODetailsViewController(nGO: nGOToSet)
        self.navigationController?.pushViewController(nGODetailViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
