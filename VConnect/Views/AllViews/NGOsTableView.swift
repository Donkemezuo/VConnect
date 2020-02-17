//
//  NGOsTableView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import CoreLocation

class NGOsTableView: UIView {
    
    private var isToggled = false
    
    
    public lazy var containView: UIView = {
        let containView = UIView()
     containView.backgroundColor = UIColor.init(hexString: "0072B1")
        return containView
        
    }()
    
    public lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .white
        return profileImageView
    }()
    
    public lazy var settingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.setImage(#imageLiteral(resourceName: "icons8-contacts_filled.png").withRenderingMode(.alwaysTemplate),for: .normal)
        settingButton.tintColor = UIColor.white
        return settingButton
        
    }()
    
    private lazy var searchBarButton: UIButton = {
        let searchBar = UIButton()
        searchBar.setImage(#imageLiteral(resourceName: "icons8-search.png").withRenderingMode(.alwaysTemplate), for: .normal)
        searchBar.tintColor = .white
        return searchBar
    }()
    
    public lazy var searchBar: UISearchBar = {
      let searchBar = UISearchBar()
        searchBar.placeholder = "Search NGOs by City"
        searchBar.barTintColor = UIColor.init(hexString: "0072B1")
        searchBar.tintColor = .red
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: UIControl.State.normal)
        return searchBar
    }()
    
    public lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "VConnect"
        textLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        
        return textLabel
    }()
    public lazy var categoriesCollectionView: UICollectionView = {
        
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.scrollDirection = .horizontal
        cellLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
         cellLayout.itemSize = CGSize.init(width: 200, height: 30)
        
        let categoriesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cellLayout)
        categoriesCollectionView.backgroundColor = UIColor.init(hexString: "0072B1")
        return categoriesCollectionView
    }()
    public lazy var nGOsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 23
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        self.nGOsTableView.register(NGOsTableViewCell.self, forCellReuseIdentifier: "NGOsTableViewCell")
        nGOsTableView.separatorStyle = .none
        
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        searchBarButton.addTarget(self, action: #selector(searchBarButtonToggled), for: .touchUpInside)
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
        setProfileImageViewConstrains()
        setTxtLabelConstrains()
        setSearchBarButtonConstrains()
        setSearchBarConstrains()
        setCollectionViewConstrains()
        setTableViewConstrains()
    }
    
    private func setContainerViewConstrains(){
        addSubview(containView)
        containView.translatesAutoresizingMaskIntoConstraints = false
        containView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        containView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        containView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setProfileImageViewConstrains(){
        containView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: containView.topAnchor, constant: 60).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: containView.trailingAnchor, constant: -30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    
    private func setSearchBarButtonConstrains(){
        containView.addSubview(searchBarButton)
        searchBarButton.translatesAutoresizingMaskIntoConstraints = false
        searchBarButton.topAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true
        searchBarButton.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 20).isActive = true
        searchBarButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        searchBarButton.heightAnchor.constraint(equalTo: textLabel.heightAnchor).isActive = true
    }
    
    private func setTxtLabelConstrains(){
        containView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: containView.trailingAnchor).isActive = true
         textLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    var heightConstraint: NSLayoutConstraint?
    
    private func setSearchBarConstrains(){
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: containView.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        heightConstraint = searchBar.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
    
    private func setCollectionViewConstrains(){
        addSubview(categoriesCollectionView)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categoriesCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    private func setTableViewConstrains(){
        addSubview(nGOsTableView)
        nGOsTableView.translatesAutoresizingMaskIntoConstraints = false
        nGOsTableView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor).isActive = true
        nGOsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nGOsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nGOsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc private func searchBarButtonToggled(){
       
        changeSearchBarHeight(bool: !isToggled)
        
    }
    
    private func changeSearchBarHeight(bool: Bool){
      isToggled = bool
        
        switch isToggled {
        case true:
            heightConstraint?.isActive = false
            heightConstraint = searchBar.heightAnchor.constraint(equalToConstant: 60)
            heightConstraint?.isActive = true
            searchBarButton.setImage(#imageLiteral(resourceName: "icons8-delete_sign_filled").withRenderingMode(.alwaysTemplate), for: .normal)
        case false:
            heightConstraint?.isActive = false
            heightConstraint = searchBar.heightAnchor.constraint(equalToConstant: 0)
            heightConstraint?.isActive = true
             searchBarButton.setImage(#imageLiteral(resourceName: "icons8-search.png").withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    public func createNGOCoordinates(withNGOFullAddress fullAddress: String, completionHandler: @escaping(Error?, CLLocationCoordinate2D?) -> Void) {
        
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
    
    public func getImages(ngo: NGO, completionHandler: @escaping ([NGOImages]) -> Void) {
        
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
    
    public func displayVConnectUserInfo(withVConnectUser vConnectUser: VConnectUser){
        if let profilePhotoURL = vConnectUser.profileImageURL {
        profileImageView.kf.setImage(with: URL(string: profilePhotoURL), placeholder:#imageLiteral(resourceName: "placeholder.png"))
        }
    }


}
