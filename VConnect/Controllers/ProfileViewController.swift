//
//  ProfileViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import FirebaseAuth
import Toucan
import CoreLocation
import Kingfisher


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTabelview: UITableView!
    
    private var profileSettingsBarButton = UIBarButtonItem()
   // private var settingController: UIViewController!
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 320 ))
        headerView.backgroundColor = UIColor.init(hexString: "033860")
        return headerView
    }()
    
    private var authService = AppDelegate.authService
    private var isExpanded = false
    private var transition = TransitionManager()
    var vConnectUserr: VConnectUser!
    private var locationManager = CLLocationManager()
    private var geoCoder = CLGeocoder()
    
    private var bookMarkedNGOs = [NGO]() {
        didSet {
            DispatchQueue.main.async {
                self.profileTabelview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "033860")
        navigationItem.title = "Profile"
        profileTabelview.tableHeaderView = profileHeaderView
        configureProfile()
        updateVConnectUserProfile()
        setupVConnectUserLocation()
        fetchUserBookMarkedNGOs()
        profileTabelview.delegate =  self
        profileTabelview.dataSource =  self
        profileTabelview.backgroundColor =  .clear
        configureBarButtonItem()
    }

    private func configureBarButtonItem(){
        profileSettingsBarButton = UIBarButtonItem(image: UIImage.init(named: "icons8-settings"), style: .plain, target: self, action: #selector(profileSettingsBarButtonPressed))
        navigationItem.leftBarButtonItem = profileSettingsBarButton
    }
    
    
    @objc private func profileSettingsBarButtonPressed(){
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        guard let settingVC = storyBoard.instantiateViewController(withIdentifier: "ProfileSettingsViewController") as? ProfileSettingsViewController else {return}
        
        settingVC.didSelectCell = { SelectedCellType in
            self.configureCellsPressed(SelectedCellType)

            
        }
        settingVC.transitioningDelegate = self
        settingVC.modalPresentationStyle = .overCurrentContext
        guard let vConnectUser = authService.getCurrentVConnectUser() else {
            showAlert(title: "Error", message: "No current signed in VConnect User")
            return
        }

    getLoggedInUser(with: vConnectUser.uid, completionHandler: { (error, vConnectUser) in
        if error != nil {
            
        } else if let vConnectUser = vConnectUser {
            settingVC.vConnectUser = vConnectUser
             self.present(settingVC, animated: true, completion: nil)
        }
        })
        
        }
    
    
    private func configureCellsPressed(_ selectedCellType: SelectedCellType){
        switch selectedCellType {
        case .profileSetting:
            break
        case .settings:
            break 
        case.logOut:
            break
        
        }
 
    }

    
    private func configureProfile(){
        profileHeaderView.vConnectUserEmailLabel.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 16)
        profileHeaderView.vConnectUserNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        profileHeaderView.vConnectUserLocationLabel.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 16)
        
        profileHeaderView.vConnectUserProfileImageView.layer.cornerRadius = profileHeaderView.vConnectUserProfileImageView.bounds.width/2
        profileHeaderView.vConnectUserProfileImageView.layer.masksToBounds = true
        profileHeaderView.vConnectUserProfileImageView.clipsToBounds = true

    }
   
    private func fetchUserBookMarkedNGOs(){
        guard let user = authService.getCurrentVConnectUser() else {return}
        DataBaseService.fetchBookMarkedNGOs(vConnectUserID: user.uid) { (error, bookMarkedNGOs) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while fetching user booked NGOs")
            } else if let bookMarkedNGOs = bookMarkedNGOs {
                self.bookMarkedNGOs = bookMarkedNGOs
            }
        }
    }

    private func setupVConnectUserLocation(){
        guard let vConnectUserLocation = locationManager.location?.coordinate else {
            return
        }
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: vConnectUserLocation.latitude, longitude: vConnectUserLocation.longitude)) { (placemark, error) in
            if error != nil {
                print("Print user location unknown")
            } else if let placemark = placemark {
                self.profileHeaderView.vConnectUserLocationLabel.text = placemark.first?.locality ?? "Unknown City"
                print(placemark.first?.locality ?? "Unknown City")
            }
        }
        
    }
    
    private func updateVConnectUserProfile(){
        guard let vConnectUser = authService.getCurrentVConnectUser() else {
            showAlert(title: "Error", message: "No current signed in VConnect User")
            return
        }
        
        DataBaseService.fetchVConnectUserr(with: vConnectUser.uid) { [weak self] (error, vConnectUser) in
            if let error = error {
                self?.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while fetching VConnect User")
            } else if let vConnectUser = vConnectUser {
                self?.profileHeaderView.vConnectUserEmailLabel.text = vConnectUser.emailAddress

                self?.profileHeaderView.vConnectUserNameLabel.text = vConnectUser.firstName + " " + vConnectUser.lastName

                guard let profilePhotoUrl = vConnectUser.profileImageURL,
                    !profilePhotoUrl.isEmpty else {return}

                self?.profileHeaderView.vConnectUserProfileImageView.kf.setImage(with:URL(string: profilePhotoUrl), placeholder:#imageLiteral(resourceName: "VCConectLogo.png") )
            }

        }

}
    
    private func getLoggedInUser(with userID: String, completionHandler: @escaping(Error?, VConnectUser?) -> Void){
      
        DataBaseService.fetchVConnectUserr(with: userID) { (error, vConnectUser) in
            if let error = error {
                completionHandler(error,nil)
                
                
            } else if let vConnectUser = vConnectUser {
                completionHandler(nil, vConnectUser)
            }
        }
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarkedNGOs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookMarkedNgo = bookMarkedNGOs[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkedCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.nGOName.text = bookMarkedNgo.ngoName
        cell.nGOCity.text = bookMarkedNgo.ngoCity
        cell.savedDate.text = bookMarkedNgo.visitedDate
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNGO = bookMarkedNGOs[indexPath.row]
        let nGOsDetailView = NGODetailsViewController(nGO: selectedNGO)
    self.navigationController?.pushViewController(nGOsDetailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension ProfileViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition

    }
}


