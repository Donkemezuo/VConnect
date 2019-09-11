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

  private var imageTapGesture: UITapGestureRecognizer!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.backgroundColor = .white
        return activityIndicator
    }()
    
    
    private lazy var loadingView: UIView = {
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.layer.cornerRadius = 10
        return loadingView
    }()
    
    private lazy var profileHeaderView: ProfileHeaderView = {
       let profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 385))
        return profileHeaderView
    }()
    
    private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
    private var profileView = ProfileView()
    private var authService = AppDelegate.authService
    private var allNGOs: [NGO]!
    private var bookMarks = [NGO]() {
        didSet {
            DispatchQueue.main.async {
                self.profileView.bookMarkedNGOsTableView.reloadData()
            }
        }
    }
    
    private var allBookMarkDates = [BookMark]() {
        didSet {
            DispatchQueue.main.async {
                self.profileView.bookMarkedNGOsTableView.reloadData()
            }
        }
    }
    
    private var vConnectUser: VConnectUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor.init(hexString: "0072B1")
        profileHeaderView.backgroundColor = UIColor.init(hexString: "0072B1")
        displayVConnectUserInfo(withVConnectUser: vConnectUser)
        fetchUserBookMarks()
        profileHeaderView.cancelButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        
        profileView.logOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        
        imagePicker.delegate = self
        view.addSubview(profileView)
        profileHeaderView.editButton.isHidden = true
        
        setupImagePicker()
        
        profileView.bookMarkedNGOsTableView.dataSource = self
        
        profileView.bookMarkedNGOsTableView.delegate = self
        
        profileHeaderView.switchSegmentedControl.addTarget(self, action: #selector(switchedSelected), for:.valueChanged)
        
         profileView.bookMarkedNGOsTableView.tableHeaderView = profileHeaderView
        
        configureEdit()
        
        profileHeaderView.profileImageView.isUserInteractionEnabled = false
    }
    
    init(allNGOs: [NGO], allBookMarkedNGOs: [NGO], allBookMarkedDates: [BookMark], vConnectUser: VConnectUser){
        super.init(nibName: nil, bundle: nil)
        
        self.allNGOs = allNGOs
        self.bookMarks = allBookMarkedNGOs
        self.allBookMarkDates = allBookMarkedDates
        self.vConnectUser = vConnectUser
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc private func dismissButtonClicked(){
        dismiss(animated: true)
    }
    
    private func showLoginView(){
            let loginScreenStoryboard = UIStoryboard(name: "AuthenticationView", bundle: nil)
            if let loginController = loginScreenStoryboard.instantiateViewController(withIdentifier: "SignInView") as? SignInViewController {
                let navController = UINavigationController.init(rootViewController: loginController)
                present(navController, animated: true) {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = navController
                }
        }
    }
    
    private func displayEditability(){
        
        let nameCell = profileView.bookMarkedNGOsTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! EditProfileTableViewCell
        nameCell.firstNameLabel.isUserInteractionEnabled = false
        nameCell.lastNameLabel.isUserInteractionEnabled = false
        nameCell.firstNameLabel.isEnabled = false
        nameCell.lastNameLabel.isEnabled = false
        profileHeaderView.profileImageView.isUserInteractionEnabled = false
         nameCell.firstNameLabel.backgroundColor = .clear
        nameCell.lastNameLabel.backgroundColor = .clear
    }
    
    private func setupActivityIndicator(){
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width/2, y: loadingView.frame.size.height/2)
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    private func turnOnEditability(){
        let nameCell = profileView.bookMarkedNGOsTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! EditProfileTableViewCell
        
        nameCell.firstNameLabel.isUserInteractionEnabled = true
        nameCell.lastNameLabel.isUserInteractionEnabled = true
        profileHeaderView.profileImageView.isUserInteractionEnabled = true
        profileHeaderView.profileImageView.backgroundColor = .gray
        nameCell.firstNameLabel.isEnabled = true
        nameCell.firstNameLabel.backgroundColor = .gray
        nameCell.lastNameLabel.isEnabled = true
        nameCell.lastNameLabel.backgroundColor = .gray
        
    }
    
    private func fetchUserBookMarks(){
        guard let userID = Auth.auth().currentUser else {return}
        DataBaseService.fetchVConnectBookMarkedNGOs(userID.uid) { (error, bookmarks) in
            if error != nil {
                print("Error")
            } else if let bookmarks = bookmarks {
                self.allBookMarkDates = bookmarks
            }
        }
    }
    

    @objc private func signOutButtonPressed(_ sender: AnyObject){
        
        print("Signout button pressed")
        
        let alertController = UIAlertController(title: "Are you sure?", message: "This action will log you out of VConnect", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            //self.dismiss(animated: true)
        }
        let deleteAction = UIAlertAction(title: "Logout", style: .destructive) { (alert) in
            self.authService.signOutVConnectUser()
            self.showLoginView()
        }
        
         alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
       
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
            
        }
        
        self.present(alertController, animated: true, completion: nil)
        
//        self.confirmDeletionActionSheet { (alert) in
//
//        }
        }
    
    private func configureLogOut(onLogOutCell logOutCell: LogOutTableViewCell){
        logOutCell.logOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        
    }
    
    private func configureEmptyBookMarksState(){
        
        if bookMarks.count > 0 {
            
            profileView.bookMarkedNGOsTableView.backgroundView = nil
            
        } else {
          profileView.bookMarkedNGOsTableView.backgroundView = EmptyView.emptyMessage(message: "You have no BookMarks", size: profileView.bookMarkedNGOsTableView.bounds.size)
            profileView.bookMarkedNGOsTableView.separatorStyle = .none
            profileView.bookMarkedNGOsTableView.backgroundColor = .red
        }
    }

    
    private func displayVConnectUserInfo(withVConnectUser vConnectUser: VConnectUser){
        profileHeaderView.fullNameLabel.text = vConnectUser.firstName + " " + vConnectUser.lastName
        profileHeaderView.emailLabel.text = vConnectUser.emailAddress
        
        if let photoURL = vConnectUser.profileImageURL {
            profileHeaderView.profileImageView.kf.setImage(with:URL(string: photoURL) , placeholder: #imageLiteral(resourceName: "placeholder.png"))
        }
        
    }
    
    private func configureEdit(){
    profileHeaderView.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)

    }
    @objc private func editButtonPressed(){

        profileHeaderView.editButton.removeTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        profileHeaderView.editButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        profileHeaderView.editButton.setTitle("Save", for: .normal)
        turnOnEditability()
        
    }
    
    @objc private func saveChanges(){
        profileHeaderView.editButton.removeTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        profileHeaderView.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
    profileHeaderView.editButton.setTitle("Edit", for: .normal)
        displayEditability()
        
       saveProfileImage(withImage: profileHeaderView.profileImageView.image!)
    }
    
    private func setupImagePicker(){
        imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileHeaderView.profileImageView.isUserInteractionEnabled = true 
        profileHeaderView.profileImageView.addGestureRecognizer(imageTapGesture)
    }
    
    @objc private func switchedSelected(){
        
        switch profileHeaderView.switchSegmentedControl.selectedSegmentIndex {
        case 0:
            profileHeaderView.editButton.isHidden = true
        case 1:
            profileHeaderView.editButton.isHidden = false
        default:
            break
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.profileHeaderView.buttonBarView.frame.origin.x = (self.profileHeaderView.switchSegmentedControl.frame.width / CGFloat(self.profileHeaderView.switchSegmentedControl.numberOfSegments)) * CGFloat(self.profileHeaderView.switchSegmentedControl.selectedSegmentIndex)
            self.profileView.bookMarkedNGOsTableView.reloadData()
        }) { (done) in
             self.profileHeaderView.buttonBarView.frame.origin.x = (self.profileHeaderView.switchSegmentedControl.frame.width / CGFloat(self.profileHeaderView.switchSegmentedControl.numberOfSegments)) * CGFloat(self.profileHeaderView.switchSegmentedControl.selectedSegmentIndex)
            self.profileView.bookMarkedNGOsTableView.reloadData()
        }
        
        
    }
    
    
    private func showImagePicker(){
        present(imagePicker, animated: true)
        
    }
    
    @objc private func profileImageTapped(){
        
        let alertController = UIAlertController(title: "Options", message: "You can change display picture from camera of photo library", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.showImagePicker()
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.showImagePicker()
        }
        
        let saveAlbums = UIAlertAction(title: "Saved Photos Album", style: .default) { (alert) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.showImagePicker()
        }
        
        let canCel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
        }
        
        alertController.addAction(camera)
        alertController.addAction(photoLibrary)
        alertController.addAction(saveAlbums)
        alertController.addAction(canCel)
        present(alertController, animated: true)
    }
    
    
    
    private func saveProfileImage(withImage image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0), let vConnectUser = authService.getCurrentVConnectUser() else {
            return
        }
        
        let nameCell = profileView.bookMarkedNGOsTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! EditProfileTableViewCell
        guard let firstName = nameCell.firstNameLabel.text, let lastName = nameCell.lastNameLabel.text, !firstName.isEmpty, !lastName.isEmpty else {
            showAlert(title: "Missing Field Required", message: "All missing fields require filling") { (alert) in

            }
            return
        }
        
        setupActivityIndicator()
        
        DataBaseService.saveProfileImage(with: imageData, with: Constants.ProfileImagePath + vConnectUser.uid) { (error, url) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let imageUrl = url {
                
                let request = vConnectUser.createProfileChangeRequest()
                
                request.photoURL = imageUrl
                request.commitChanges(completion: { (error) in
                    if let error = error {
                        self.showAlert(title: "Error", message: "Error \(error.localizedDescription) while changing display picture")
                    } else {
                        self.activityIndicator.stopAnimating()
                        self.loadingView.removeFromSuperview()
                        
                        self.showAlert(title: "Success", message: "Successfully changed profile information")
                    }
                })
                DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(vConnectUser.uid).updateData([VConnectUserCollectionKeys.profileImageURL:imageUrl.absoluteString, VConnectUserCollectionKeys.firstName: firstName, VConnectUserCollectionKeys.lastName:lastName], completion: { (error) in
                    if let error = error {
                        print("Error: \(error)")
                    }
                })
            }
        }
        
    }

    @objc private func canCelButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
    
}



extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch profileHeaderView.switchSegmentedControl.selectedSegmentIndex {
        case 0:
            if bookMarks.isEmpty {
                tableView.separatorStyle = .none
                return 1
            } else {
                   return bookMarks.count
            }
    

        case 1:
            return 3
        default:
            return 0
        }
        
     

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = .clear

        switch profileHeaderView.switchSegmentedControl.selectedSegmentIndex {
            
        case 0:
        profileView.bookMarkedNGOsTableView.separatorStyle = .singleLine
            let genericCell = UITableViewCell()
            
            if bookMarks.isEmpty {
                genericCell.backgroundView = EmptyView.emptyMessage(message: "No BookMarks", size: genericCell.bounds.size)
                profileView.bookMarkedNGOsTableView.isScrollEnabled = false
                genericCell.selectionStyle = .none
                return genericCell
                
            } else {
                let bookMarkedNGO = bookMarks[indexPath.row]
                //dump(bookMarkedNGO)
                let date = allBookMarkDates[0]
                //dump(allBookMarkDates.count)
                guard let bookMarkCell = tableView.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath) as? BookMarkedTableViewCell  else {
                    return UITableViewCell()
                }
                bookMarkCell.backgroundColor = .clear
                bookMarkCell.ngoName.text = bookMarkedNGO.ngoName
                bookMarkCell.addressLabel.text = bookMarkedNGO.ngoCity
                bookMarkCell.savedDate.text = "Bookmarked since \(date.date)"
                return bookMarkCell
            }
        case 1:
            
    profileView.bookMarkedNGOsTableView.separatorStyle = .none
            switch indexPath.row {
                
            case 0:
                 guard let profileSettingsCell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath) as? EditProfileTableViewCell else {return UITableViewCell()}
                 profileSettingsCell.firstNameLabel.text = vConnectUser.firstName
                 profileSettingsCell.lastNameLabel.text = vConnectUser.lastName
                 profileSettingsCell.backgroundColor = .clear
                 profileSettingsCell.selectionStyle = .none
                return profileSettingsCell
                
            case 1:
                guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "EmailCell", for: indexPath) as? EmailTableViewCell else {return UITableViewCell()}
                emailCell.emailLabel.text = vConnectUser.emailAddress
                emailCell.backgroundColor = .clear
                emailCell.selectionStyle = .none
                return emailCell
                
            case 2:
                guard let logOutCell = tableView.dequeueReusableCell(withIdentifier: "LogOutCell", for: indexPath) as? LogOutTableViewCell else {return UITableViewCell()}
                logOutCell.backgroundColor = .clear
                logOutCell.selectionStyle = .none
                configureLogOut(onLogOutCell: logOutCell)
                return logOutCell
                
            default:
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch profileHeaderView.switchSegmentedControl.selectedSegmentIndex {
        case 0:
            if bookMarks.isEmpty {
                return tableView.bounds.height * 0.5
            } else {
                return tableView.bounds.height * 0.12
            }
        case 1:
            return tableView.bounds.height * 0.13
        default:
            return 0
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
        profileHeaderView.profileImageView.image = resizedImage
        dismiss(animated: true, completion: nil)
        
    }
    
}
