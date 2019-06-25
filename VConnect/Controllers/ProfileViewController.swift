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


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTabelview: UITableView!
    
    private var profileSettingsBarButton = UIBarButtonItem()
    private var settingController: UIViewController!
    
    private var selectedImage: UIImage?
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 320 ))
        headerView.backgroundColor = UIColor.init(hexString: "033860")
        return headerView
    }()
    
    private var authService = AppDelegate.authService
    private var isExpanded = false
    private var transition = TransitionManager()
    var vConnectUserr: VConnectUser!
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
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
        imagePicker.delegate = self
        configureProfile()
        updateVConnectUserProfile()
        editvConnectUserProfileImage()
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
    
    private func saveUserImage(with Image: UIImage?) {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 1.0), let loggedInUser = authService.getCurrentVConnectUser() else {
            showAlert(title: "Missing Fields", message: "A photo and login required")
            return
        }
        
        DataBaseService.saveProfileImage(with: imageData, with: Constants.ProfileImagePath + loggedInUser.uid) { (error, profileImageUrl) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while saving image")
            } else {
                if let imageURL = profileImageUrl {
                    print(imageURL)
                    let request = loggedInUser.createProfileChangeRequest()
                    request.photoURL = imageURL
                    request.commitChanges(completion: { (error) in
                        if let error = error {
                            self.showAlert(title: "Error saving info", message: error.localizedDescription)
                        }
                    })
                    
                    DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(loggedInUser.uid).updateData([VConnectUserCollectionKeys.profileImageURL : imageURL.absoluteString], completion: { (error) in
                        if let error = error {
                            self.showAlert(title: "Error", message: error.localizedDescription)
                        }
                    })
                }
            }
        }
        
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
        
        /*
 
         case profileSetting
         case becomeSpecialist
         case registerNGO
         case logOut
 
         */
        
        switch selectedCellType {
        case .profileSetting:
            break
        case .becomeSpecialist:
        break
        case .registerNGO:
        navigationController?.pushViewController(NGORegistrationTableViewController(), animated: true)
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
    
    
//
//    private func setUserProfileImage(selectedImage: UIImage) {
//        guard let imageData = selectedImage.jpegData(compressionQuality: 1.0), let loggedInUser = authService.getCurrentVConnectUser(), let _ = profileHeaderView.vConnectUserProfileImageView.image else {return}
//        DataBaseService.saveProfileImage(with: imageData, with: Constants.ProfileImagePath + loggedInUser.uid) {[weak self] (error, imageUrl) in
//            if let _ = error {
//
//            } else if let imageUrl = imageUrl {
//                let profileImageRequest = loggedInUser.createProfileChangeRequest()
//                profileImageRequest.photoURL = imageUrl
//                profileImageRequest.commitChanges(completion: { (error) in
//                    if let error = error {
//                        self?.showAlert(title: "Error saving image", message: error.localizedDescription)
//                    }
//                })
//
//        DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(loggedInUser.uid).updateData([VConnectUserCollectionKeys.profileImageURL : imageUrl.absoluteString], completion: { (error) in
//                    if let error = error {
//                       self?.showAlert(title: "Error saving image", message: error.localizedDescription)
//                    }
//                })
//                self?.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    
    
    private func editvConnectUserProfileImage(){
        profileHeaderView.vConnectUserProfileImageView.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileImageClicked))
        profileHeaderView.vConnectUserProfileImageView.addGestureRecognizer(tapGesture)
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
    
    private func showImagePicker(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func editProfileImageClicked(){
        
        let alertController = UIAlertController(title: "Edit Profile Image?", message: "You can change your profile image", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.showImagePicker()
        }
        
        let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.showImagePicker()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
          self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(camera)
        alertController.addAction(photoLibrary)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    private func updateVConnectUserProfile(){
        guard let vConnectUser = authService.getCurrentVConnectUser() else {
            showAlert(title: "Error", message: "No current signed in VConnect User")
            return
        }
        
        print(vConnectUser.displayName ?? "")
        
        DataBaseService.fetchVConnectUser(vConnectUserID: vConnectUser.uid) {[weak self] (error, vConnectUser) in
            if let error = error {
                self?.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while fetching VConnect User")
            } else {
                if let vConnectUser = vConnectUser {
                    self?.profileHeaderView.vConnectUserEmailLabel.text = vConnectUser.emailAddress

                    self?.profileHeaderView.vConnectUserNameLabel.text = vConnectUser.firstName + " " + vConnectUser.lastName
                    
                    guard let profilePhotoUrl = vConnectUser.profileImageURL,
                        !profilePhotoUrl.isEmpty else {return}
                    
                
                    
                    
            }
        }
    }
    
}
    
    private func getLoggedInUser(with userID: String, completionHandler: @escaping(Error?, VConnectUser?) -> Void){
      
        DataBaseService.fetchVConnectUser(vConnectUserID: userID) { (error, vConnectUser) in
            if let error = error {
                completionHandler(error,nil)
                
                
            } else if let vConnectUser = vConnectUser {
                completionHandler(nil, vConnectUser)
            }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        let size = CGSize(width: 500, height: 500)
        let resizedImage = Toucan.Resize.resizeImage(originalImage, size: size)
        selectedImage = resizedImage
        profileHeaderView.vConnectUserProfileImageView.image = resizedImage
        saveUserImage(with: resizedImage)
        
        
        //let resizedProfileImage = Toucan.init(image: originalImage).resize(CGSize(width: 500, height: 500))
        
        //profileHeaderView.vConnectUserProfileImageView.image = resizedProfileImage.image
//        guard let processedImage = resizedProfileImage.image else {return}
//        setUserProfileImage(selectedImage: processedImage)
//        updateVConnectUserProfile()
        dismiss(animated: true, completion: nil)
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


