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
    
    private lazy var profileHeaderView: ProfileHeaderView = {
       let profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 543))
        
        return profileHeaderView
    }()
    
    private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    private var profileView = ProfileView()
    private var authService = AppDelegate.authService
    private var bookMarks = [NGO]() {
        didSet {
            DispatchQueue.main.async {
                self.profileView.bookMarkedNGOsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.isOpaque = false
       // setProfileViewConstrains()
        profileHeaderView.backgroundColor = UIColor.init(hexString: "0072B1")
        fetchUser(withVConnectUserID: authService.getCurrentVConnectUser()!.uid)
        profileHeaderView.cancelButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        profileHeaderView.logOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        imagePicker.delegate = self
        view.addSubview(profileView)
        profileView.bookMarkedNGOsTableView.tableHeaderView = profileHeaderView
        fetchBookMarks()
        setupImagePicker()
        profileView.bookMarkedNGOsTableView.dataSource = self
        profileView.bookMarkedNGOsTableView.delegate = self
    }
    
    @objc private func dismissButtonClicked(){
        dismiss(animated: true)
    }
    
    private func showLoginView(){
        //if let _ = storyboard?.instantiateViewController(withIdentifier: "NGOsViewController") as? HomeViewController {
            
            let loginScreenStoryboard = UIStoryboard(name: "AuthenticationView", bundle: nil)
            
            if let loginController = loginScreenStoryboard.instantiateViewController(withIdentifier: "SignInView") as? SignInViewController {
                let navController = UINavigationController.init(rootViewController: loginController)
                present(navController, animated: true) {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = navController
                }
              
                
        }
    }
    //}
    @objc private func signOutButtonPressed(){
        
        self.confirmDeletionActionSheet { (alert) in
            self.authService.signOutVConnectUser()
            self.showLoginView()
        }
        
   

        }
    
    
    private func fetchUser(withVConnectUserID ID: String) {
        DataBaseService.fetchVConnectUserr(with: ID) { (error, vconnectUser) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while fetching VConnect User")
            } else if let vConnectUser = vconnectUser {
                self.displayVConnectUserInfo(withVConnectUser: vConnectUser)
                
            }
        }
    }
    
    private func displayVConnectUserInfo(withVConnectUser vConnectUser: VConnectUser){
        //profileHeaderView.helloLabel.text = "Hello \(vConnectUser.firstName)"
        profileHeaderView.emailTxtField.text = vConnectUser.emailAddress
        profileHeaderView.firstNameTxtField.text = vConnectUser.firstName
        profileHeaderView.lastNameTxtField.text = vConnectUser.lastName
        if let photoURL = vConnectUser.profileImageURL {
        profileHeaderView.profileImageView.kf.setImage(with: URL(string: photoURL), placeholder:#imageLiteral(resourceName: "icons8-contacts_filled.png"))
        }
       
        
    }
    
    private func setupImagePicker(){
        imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileHeaderView.profileImageView.isUserInteractionEnabled = true 
        profileHeaderView.profileImageView.addGestureRecognizer(imageTapGesture)
        
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
            self.dismiss(animated: true)
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
                        self.showAlert(title: "Success", message: "Successfully changed profile picture")
                        //self.dismiss(animated: true)
                    }
                })
                
                DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(vConnectUser.uid).updateData([VConnectUserCollectionKeys.profileImageURL:imageUrl.absoluteString], completion: { (error) in
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
    
    private func fetchBookMarks(){
        guard let vconnectUserID = authService.getCurrentVConnectUser()?.uid else {
            return
        }
        
        DataBaseService.fetchBookMarkedNGOs(vConnectUserID: vconnectUserID) { (error, bookMarks) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching book marks")
            } else if let bookMarks = bookMarks {
                self.bookMarks = bookMarks
                
                //dump(bookMarks)
                
            }
        }
    }

}



extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookMarkCell = tableView.dequeueReusableCell(withIdentifier: "BookMarkedTableViewCell", for: indexPath) as? BookMarkedTableViewCell  else {
            return UITableViewCell()
        }
        
        let bookMark = bookMarks[indexPath.row]
        bookMarkCell.ngoName.text = bookMark.ngoName
        bookMarkCell.addressLabel.text = bookMark.ngoStreetAddress + " " + bookMark.ngoCity
        bookMarkCell.savedDate.text = bookMark.visitedDate
        bookMarkCell.backgroundColor = .clear
        bookMarkCell.textLabel?.textColor = .white
        return bookMarkCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        saveProfileImage(withImage: resizedImage!)
        dismiss(animated: true, completion: nil)
        
    }
    
}
