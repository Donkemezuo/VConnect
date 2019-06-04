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
    private var coordinates = CLLocationCoordinate2D()
    var locations: CLLocation!
    var defaultCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
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
        makeAnnotations()
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
            nGOsMapView.removeFromSuperview()
            nGOsView.resourcesView.addSubview(nGOsTableView)
        case 1:
            nGOsTableView.removeFromSuperview()
            nGOsView.resourcesView.addSubview(nGOsMapView)
        default:
            return
            
        }
    }
    
    private func generateNGOLocationCoordinates(with NGOFullAddress: String, completionHandler:  @escaping(Error?, CLLocationCoordinate2D?) -> Void){
        
        GoogleAddressAPIClient.getAddressCoordinates(fullAddress: NGOFullAddress) { (error, fetchResults) in
            if let error = error {
                completionHandler(error, nil)
  
            } else if let fetchedResults = fetchResults {
                let coordinatesFromFetchedResult = fetchedResults.results.first?.geometry
                guard let latitude = coordinatesFromFetchedResult?.location.lat, let longitude = coordinatesFromFetchedResult?.location.lng else {
                    return
                }
           completionHandler(nil, CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                
            }
        }
    }
    
    
    private func makeAnnotations() {
    nGOsMapView.mapView.removeAnnotations(annotations)
        
        for ngo in allNGOsInCategory {
     generateNGOLocationCoordinates(with: ngo.fullAddress) { (error, coordinate) in
                if let error = error {
                   self.showAlert(title: "Error", message: error.localizedDescription)
                } else if let addressCoordinates = coordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(addressCoordinates.latitude, addressCoordinates.longitude)
            let region = MKCoordinateRegion(center: addressCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    self.nGOsMapView.mapView.setRegion(region, animated: true)
                    print(addressCoordinates)
                    annotation.title = ngo.ngoName
                    self.annotations.append(annotation)
                    
                }
            }

        }
        nGOsMapView.mapView.addAnnotations(annotations)
        nGOsMapView.mapView.showAnnotations(annotations, animated: true)
    
        
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
