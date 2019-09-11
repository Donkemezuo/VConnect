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
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    let nGOsTableView = NGOsTableView()
    private var coordinates = CLLocationCoordinate2D()
    var userCoordinates = CLLocationCoordinate2D()
    private var tapGesture: UITapGestureRecognizer!
    private var authService = AppDelegate.authService
    var vConnectUser: VConnectUser?
    var bookMarks = [NGO]()
    var allUserBookMarkIDs = [BookMark]()
    var allNGOs = [NGO]() {
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
    
    private var nGOCategories = ["Domestic Violence", "Children", "Sexual Assault", "Human Rights", "Women", "Youth Development", "Education", "Leadership Training", "Children and Women", "Widows Affairs", "Girl Child"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsTableView)
        view.backgroundColor = UIColor(hexString: "#ffffff")
        self.navigationController?.isNavigationBarHidden = true
        presentVConnectUserProfile()
        nGOsTableView.nGOsTableView.delegate =  self
        nGOsTableView.nGOsTableView.dataSource = self
        nGOsTableView.categoriesCollectionView.dataSource = self
        nGOsTableView.categoriesCollectionView.delegate = self
        nGOsTableView.searchBar.delegate = self
        nGOsTableView.searchBar.showsCancelButton = true
        getBookmarkedNGOsID()
        vConnectUserSearchedNGOsInCategory = allNGOs
    }
    
    private func fetchVConnectUser(withUserID userID: String) {
            DataBaseService.fetchVConnectUserr(with:userID) { (error, vconnectUser) in
                if let error = error {
                    self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching user")
                } else if let vConnectUser = vconnectUser {
                    self.vConnectUser = vConnectUser
                    self.nGOsTableView.displayVConnectUserInfo(withVConnectUser: vConnectUser)
                 }
            }
        } // This method is fetching a logged in VConnect user from firebase
    
        private func getBookmarkedNGOsID(){
            guard let vconnectUser = Auth.auth().currentUser else { return}
            DataBaseService.fetchVConnectBookMarkedNGOs(vconnectUser.uid) { (error, bookmarks) in
                if let error = error {
                    self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching book marks")
                } else if let bookmarks = bookmarks {
                    self.allUserBookMarkIDs = bookmarks
                    self.allUserBookMarkIDs.removeAll()
                    for bookmarkedNGO in bookmarks {
                        for ngo in self.allNGOs {
                            if bookmarkedNGO.ngoID == ngo.ngOID {
                                self.bookMarks.append(ngo)
                            }
                        }
                    }
                }
            }
        } // This method is fetching all the bookmarked nGOs of a logged in VConnect user from firebase
    
    private func presentVConnectUserProfile(){
        guard let userID = Auth.auth().currentUser else { ///
            nGOsTableView.profileImageView.isHidden = true
            return
        }
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentProfileVC))
        nGOsTableView.profileImageView.addGestureRecognizer(tapGesture)
        nGOsTableView.profileImageView.isUserInteractionEnabled = true
        fetchVConnectUser(withUserID: userID.uid)
    } // This method is presenting the vconnect user on the profile view
    
    @objc private func presentProfileVC(){
        guard let vConnectUser = vConnectUser else {return}
       let profileVC = ProfileViewController(allNGOs: allNGOs, allBookMarkedNGOs: bookMarks, allBookMarkedDates: allUserBookMarkIDs, vConnectUser: vConnectUser)
     present(profileVC, animated: true)
    } // This method gets called when the profile icon is pressed on the view
    private func generateMilesDifference(with cell: NGOsTableViewCell){
        
        let userCurrentLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
        let nGOLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let distanceFromNGO = userCurrentLocation.distance(from: nGOLocation)
        let distanceInMiles = distanceFromNGO/1609.344
        cell.nGOMiles.text = String(format: "%.0f", distanceInMiles) + " " + "Miles"
        
    } // This method takes the vConnect user location and that of an NGO and find the miles difference
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vConnectUserSearchedNGOsInCategory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nGOsCell = tableView.dequeueReusableCell(withIdentifier: "NGOsTableViewCell", for: indexPath) as? NGOsTableViewCell else {return UITableViewCell()}
        
    let nGOToSet = vConnectUserSearchedNGOsInCategory[indexPath.row]
        nGOsCell.setCellInfo(withNGO: nGOToSet)
        generateMilesDifference(with: nGOsCell)
    nGOsCell.setRatingValue(with: nGOToSet.ratingsValue)
    return nGOsCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nGOToSet =  vConnectUserSearchedNGOsInCategory[indexPath.row]
        nGOsTableView.getImages(ngo: nGOToSet) { (ngoImages) in
              nGOToSet.ngoImagesURL = ngoImages
            self.nGOsTableView.createNGOCoordinates(withNGOFullAddress: nGOToSet.fullAddress, completionHandler: { (error, coordinates) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let coordinate = coordinates {
                    DispatchQueue.main.async {
                        let ngoDetailVC = NGODetailsViewController(nGO: nGOToSet, userLocationCoordinate: self.userCoordinates, ngoCoordinates: coordinate, bookMarkIDs: self.allUserBookMarkIDs)
                        ngoDetailVC.detailVCDelegate = self
                        self.navigationController?.pushViewController(ngoDetailVC, animated: true)
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
        return categoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nGOsInCategory = nGOCategories[indexPath.row]
        vConnectUserSearchedNGOsInCategory = vConnectUserSearchedNGOsInCategory.filter {$0.ngoCategory == nGOsInCategory}
        if vConnectUserSearchedNGOsInCategory.count == 0 {
            showAlert(title: "Sorry", message: "There are currently no registered NGOs in the \(nGOsInCategory) Category. Please check back later as we continue to grow our support community. Thank you")
            vConnectUserSearchedNGOsInCategory = allNGOs
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

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedCity = searchBar.text else { return}
     vConnectUserSearchedNGOsInCategory = vConnectUserSearchedNGOsInCategory.filter{$0.ngoCity.lowercased().contains(searchedCity.lowercased())}
    nGOsTableView.nGOsTableView.reloadData()

        if searchedCity == "" {
        vConnectUserSearchedNGOsInCategory = allNGOs
        nGOsTableView.nGOsTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        vConnectUserSearchedNGOsInCategory = allNGOs
        nGOsTableView.nGOsTableView.reloadData()
        searchBar.text = " "
    }
    
}

extension HomeViewController: DetailVCDelegate {
    func didBookMarkedNGO(withBookMarkedIDs: [BookMark]) {
        self.allUserBookMarkIDs = withBookMarkedIDs
    }
    
    
}
