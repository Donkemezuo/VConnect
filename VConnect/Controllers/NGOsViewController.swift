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

class HomeViewController: UIViewController {
    let nGOsTableView = NGOsTableView()
    private var geoCoder = CLGeocoder()
    private var coordinates = CLLocationCoordinate2D()
    private var userCoordinates = CLLocationCoordinate2D()
    private var tapGesture: UITapGestureRecognizer!
    var vConnectUser: VConnectUser!
    private var bookMarks = [NGO]()
    private var allUserBookMarkIDs = [BookMark]()
    private var allNGOs = [NGO]() {
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
private var cellSpacing = UIScreen.main.bounds.size.width * 0.001
    
    private var vConnectUserSearchedNGOsInCategory = [NGO](){
        
        didSet {
            DispatchQueue.main.async {
                self.nGOsTableView.nGOsTableView.reloadData()
            }
        }
    }
    
    
    private var nGOCategories = ["Domestic Violence", "Child issues", "Sexual Assault", "Human Rights", "Women", "Youth Development", "Education", "Housing", "Leadership"]
    private var isSearching: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsTableView)
       // view.backgroundColor = UIColor.init(hexString: "dcd9cd")
        view.backgroundColor = UIColor(hexString: "#ffffff")
        self.navigationController?.isNavigationBarHidden = true
        nGOsTableView.nGOsTableView.delegate =  self
        nGOsTableView.nGOsTableView.dataSource = self
        nGOsTableView.categoriesCollectionView.dataSource = self
        nGOsTableView.categoriesCollectionView.delegate = self
        presentVConnectUserProfile()
    }
    
    init(allRegisteredNGOs: [NGO], allBookmarkedNGOs: [NGO], allBookmarkedDates: [BookMark], vConnectUser: VConnectUser, userCoordinates: CLLocationCoordinate2D){
        
        super.init(nibName: nil, bundle: nil)
        self.allNGOs = allRegisteredNGOs
        self.allUserBookMarkIDs = allBookmarkedDates
        self.bookMarks = allBookmarkedNGOs
        self.vConnectUser = vConnectUser
        self.userCoordinates = userCoordinates
        self.displayVConnectUserInfo(withVConnectUser: vConnectUser)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func createNGOCoordinates(withNGOFullAddress fullAddress: String, completionHandler: @escaping(Error?, CLLocationCoordinate2D?) -> Void) {
        
        GoogleAddressAPIClient.getAddressCoordinates(fullAddress: fullAddress) { (error, fetchResults) in
            if let error = error {
                completionHandler(error, nil)
            } else if let fetchedResults = fetchResults {
                
                let coordinatesFromFetchedResults = fetchedResults.results.first?.geometry
                
                guard let latitude = coordinatesFromFetchedResults?.location.lat, let longitude = coordinatesFromFetchedResults?.location.lng else {
                    return
                }
                
                completionHandler(nil, CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
        }
        
    }

    
    private func displayVConnectUserInfo(withVConnectUser vConnectUser: VConnectUser){
        if let profilePhotoURL = vConnectUser.profileImageURL {
            nGOsTableView.profileImageView.kf.setImage(with: URL(string: profilePhotoURL), placeholder:#imageLiteral(resourceName: "placeholder.png"))
        }
    }
    
    private func presentVConnectUserProfile(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentProfileVC))
        nGOsTableView.profileImageView.addGestureRecognizer(tapGesture)
        nGOsTableView.profileImageView.isUserInteractionEnabled = true
    }
    
    @objc private func presentProfileVC(){
        let profileVC = ProfileViewController(allNGOs: allNGOs, allBookMarkedNGOs: bookMarks, allBookMarkedDates: allUserBookMarkIDs, vConnectUser: vConnectUser)
     present(profileVC, animated: true)
    }
    
    
    private func generateMilesDifference(with cell: NGOsTableViewCell){
        
        let userCurrentLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
        let nGOLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let distanceFromNGO = userCurrentLocation.distance(from: nGOLocation)
        let distanceInMiles = distanceFromNGO/1609.344
        cell.nGOMiles.text = String(format: "%.0f", distanceInMiles) + " " + "Miles"
        
    }
    
    
    func getImages(ngo: NGO, completionHandler: @escaping ([NGOImages]) -> Void) {
        
        var nGOImages = [NGOImages]()
        DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(ngo.ngOID).collection(Constants.nGOImagesPath).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error.localizedDescription) encountered while fetching documents")
            } else if let snapShot = snapshot {
                
                for document in snapShot.documents {
                    let ngoImage = NGOImages.init(dict: document.data())
                    nGOImages.append(ngoImage)
                    
                }
                
                completionHandler(nGOImages)
                
            }
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
    
    
    private func setRatingValue(with ratingValue: Double, on nGOCell: NGOsTableViewCell) {
        nGOCell.cosmosView.settings.starMargin = 3.5
        nGOCell.cosmosView.settings.totalStars =  5
        nGOCell.cosmosView.settings.updateOnTouch = false
       nGOCell.cosmosView.rating = ratingValue
      nGOCell.cosmosView.settings.fillMode = .half
        nGOCell.cosmosView.settings.starSize = 25
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? vConnectUserSearchedNGOsInCategory.count : allNGOs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nGOsCell = tableView.dequeueReusableCell(withIdentifier: "NGOsTableViewCell", for: indexPath) as? NGOsTableViewCell else {return UITableViewCell()}
        
    let nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOs[indexPath.row]
    nGOsCell.nGOName.text = nGOToSet.ngoName
    nGOsCell.nGOCity.text = nGOToSet.ngoCity
    nGOsCell.selectionStyle = .none
    nGOsCell.backgroundColor = .clear
    nGOsCell.containerView.backgroundColor = UIColor.white
        generateMilesDifference(with: nGOsCell)
    setRatingValue(with: nGOToSet.ratingsValue, on: nGOsCell)
    return nGOsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nGOToSet = isSearching ? vConnectUserSearchedNGOsInCategory[indexPath.row] : allNGOs[indexPath.row]
        getImages(ngo: nGOToSet) { (ngoImages) in
            nGOToSet.ngoImagesURL = ngoImages
            let nGODetailViewController = NGODetailsViewController(nGO: nGOToSet, allBookMarks: self.allUserBookMarkIDs)
            nGODetailViewController.userLocationCoordinates = self.userCoordinates
            self.createNGOCoordinates(withNGOFullAddress: nGOToSet.fullAddress, completionHandler: { (error, coordinates) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let coordinate = coordinates {
                    DispatchQueue.main.async {
                    nGODetailViewController.ngoLocationCoordinates = coordinate
 self.navigationController?.pushViewController(nGODetailViewController, animated: true)
                    }
                }
            })
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nGOCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else {return UICollectionViewCell()}
        let category = nGOCategories[indexPath.row]
        categoryCell.categoryNameLabel.text = category
        categoryCell.backgroundColor = .clear
        categoryCell.layer.borderWidth = 1
        categoryCell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        categoryCell.layer.cornerRadius = 5
        return categoryCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nGOsInCategory = nGOCategories[indexPath.row]
        isSearching = true
        vConnectUserSearchedNGOsInCategory = allNGOs.filter {$0.ngoCategory == nGOsInCategory}
        
        if vConnectUserSearchedNGOsInCategory.count == 0 {
            showAlert(title: "Sorry", message: "There are currently no registered NGOs in the \(nGOsInCategory) Category. Please check back later as we continue to grow our support community. Thank you")
            isSearching = false
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells:CGFloat = 1.65
        let numberOfSpaces:CGFloat = numberOfCells + 0.5
        let screenWidth = UIScreen.main.bounds.width
        let height:CGFloat = nGOsTableView.categoriesCollectionView.bounds.size.height
        return CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) / numberOfCells, height: height * 0.8)
        
    }
    
    
    
    
}
