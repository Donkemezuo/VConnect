//
//  VConnectUserProfileSettingsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/30/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import FirebaseStorage
import Toucan

class VConnectUserProfileSettingsViewController: UIViewController {
    
   public var vConnectUserProfileSettingsView = VConnectUserProfileSettingsView()

    private var authServices = AppDelegate.authService
    
    var vConnectUser:VConnectUser!
    private var profileImage: UIImage!
    private var selectedImage: UIImage?
    private var email: String!
    private var firstName: String!
    private var lastName: String!
    private var tapGesture: UITapGestureRecognizer!
    
    private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(vConnectUserProfileSettingsView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        vConnectUserProfileSettingsView.cancelButton.addTarget(self, action: #selector(canCelButtonPressed), for: .touchUpInside)
        
        vConnectUserProfileSettingsView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        defaultSettings()
        imagePicker.delegate = self
        editvConnectUserProfileImage()
        
    }
    
    private func defaultSettings(){
        vConnectUserProfileSettingsView.emailInputTextField.text = vConnectUser.emailAddress
        vConnectUserProfileSettingsView.firstNameInputTextField.text = vConnectUser.firstName
        vConnectUserProfileSettingsView.lastNameInputTextField.text = vConnectUser.lastName
        if let photoURL = vConnectUser.profileImageURL {
            vConnectUserProfileSettingsView.profileImageView.kf.setImage(with: URL(string: photoURL), placeholder: #imageLiteral(resourceName: "icons8-contacts_filled.png"))
            
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
    
    private func editvConnectUserProfileImage(){
        vConnectUserProfileSettingsView.profileImageView.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileImageClicked))
        vConnectUserProfileSettingsView.profileImageView.addGestureRecognizer(tapGesture)
    }

    
    @objc private func canCelButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonPressed(){
        
        guard let profileImageData = selectedImage?.jpegData(compressionQuality: 1.0),
            let user = authServices.getCurrentVConnectUser(),
            let userFirstName = vConnectUserProfileSettingsView.firstNameInputTextField.text,
            let userLastName = vConnectUserProfileSettingsView.lastNameInputTextField.text,
            let userEmail = vConnectUserProfileSettingsView.emailInputTextField.text,
            !userFirstName.isEmpty,
            !userLastName.isEmpty,
            !userEmail.isEmpty else {
                self.showAlert(title: "Missing Fields", message: "A photo and username are Required")
                
                return
        }
        
        DataBaseService.saveProfileImage(with: profileImageData, with: Constants.ProfileImagePath + user.uid) { (error, profileImageUrl) in
            if let error = error {
                                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while saving image")
            } else if let imageUrl = profileImageUrl {
                let request = user.createProfileChangeRequest()
                request.photoURL = imageUrl
                request.commitChanges(completion: { (error) in
                    if let error = error {
                        self.showAlert(title: "Error saving info", message: error.localizedDescription)
                    } else {
                        self.showAlert(title: "Success", message: "Hi \(userFirstName), Your information has been successfully updated", handler: { (alert) in
                            self.dismiss(animated: true, completion: nil)
                        })
                    }
                })
                DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(user.uid).updateData([VConnectUserCollectionKeys.profileImageURL: imageUrl.absoluteString, VConnectUserCollectionKeys.emailAddress: userEmail, VConnectUserCollectionKeys.firstName: userFirstName, VConnectUserCollectionKeys.lastName: userLastName], completion: { (error) in
                    if let error = error {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                    }
                })
                
            }
        }
        
    }
    

}

extension VConnectUserProfileSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        vConnectUserProfileSettingsView.profileImageView.image = resizedImage
        dismiss(animated: true, completion: nil)
        
    }
    
}
