//
//  NGODetailsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/31/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGODetailsViewController: UIViewController {
    
    private var nGOsDetailView = NGOsDetailView()
    private var nGO: NGO!
    private var barButtonItem = UIBarButtonItem()
    private var authService = AppDelegate.authService
    private var allNGOReviews = [NGOReviews]() {
        didSet {
            DispatchQueue.main.async {
                self.nGOsDetailView.reviewView.reviewsTableView.reloadData()
            }
        }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsDetailView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        nGOsDetailView.ngoPhotosView.nGOPhotosCollectionView.delegate = self
        nGOsDetailView.ngoPhotosView.nGOPhotosCollectionView.dataSource = self
        nGOsDetailView.reviewView.reviewsTableView.delegate = self
        nGOsDetailView.reviewView.reviewsTableView.dataSource = self
        nGOInformations()
        setupBarButtonItem()
        fetchReviews(with: nGO.ngOID)
        nGOsDetailView.reviewView.backgroundColor = .clear
        
        setUpPostButton()
    }
    
    init(nGO: NGO) {
        super.init(nibName: nil, bundle: nil)
        self.nGO = nGO
        //setUpPostButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func nGOInformations(){
        nGOsDetailView.nGODescription.text = """
Mission:

     \(nGO.ngoDescription)


"""
nGOsDetailView.nGOWebsite.text = nGO.ngoWebsite

        
nGOsDetailView.ngoAddressView.addressTextView.text = nGO.fullAddress
  
nGOsDetailView.ngoAddressView.contactInfoTextView.text = """

\(nGO.contactPersonName)
        
\(nGO.ngoEmail)
        
\(nGO.ngoPhoneNumber)


"""

nGOsDetailView.ngoAddressView.operationalHoursTextView.text = """
    
Monday:     \(nGO.mondayHours)
        
Tuesday:    \(nGO.tuesdayHours)
        
Wednesday:  \(nGO.wedsDayHours)
        
Thursday:   \(nGO.thursdayHours)
        
Friday:     \(nGO.fridayHours)
        
Saturday:   \(nGO.saturdayHours)
        
Sunday:     \(nGO.sundayHours)

"""
        
    }
    
    
    
    private func setupBarButtonItem(){
        barButtonItem = UIBarButtonItem(title: "BookMark NGO", style: .plain, target: self, action: #selector(barButtonItemSelected))
    navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func barButtonItemSelected(){
        guard let loggedInVConnectUser = authService.getCurrentVConnectUser() else {
            showAlert(title: "Error", message: "Only logged in users can book mark NGOs")
            return
        }
        DataBaseService.createVConnectUserNGOBookMark(vConnectUserID: loggedInVConnectUser.uid, bookMarkedNGOs: nGO) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription) while book marking NGO")
            } else {
                self.showAlert(title: "Success", message: "Successfully book marked NGO. This NGO will appear on your profile tab")
            }
        }
        
    }
    
    private func fetchNGOImages(photoURL: String, photoCell: NGOPhotosCollectionViewCell){
        ImageHelper.fetchImage(urlString: photoURL) { (error, image) in
            if error != nil {
                self.showAlert(title: "Error", message: "Error: Can't load NGO images")
            } else if let image = image {
                photoCell.ngoPhotoView.image = image
                
            }
        }
        
    }
    
    private func fetchReviewer(with reviewerID: String, reviewCell: ReviewsTableViewCell){
        DataBaseService.fetchVConnectUser(vConnectUserID: reviewerID) { (error, reviewer) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error:\(error.localizedDescription) encountered fetching reviewer information")
            } else if let reviewer = reviewer {
                reviewCell.reviewerName.text = reviewer.firstName + " " + reviewer.lastName
                if let photoURL = reviewer.profileImageURL {
                reviewCell.reviewerProfileImage.kf.setImage(with:URL(string: photoURL) , placeholder: #imageLiteral(resourceName: "icons8-contacts_filled.png"))
                }
               
            }
        }
    }
    
    private func fetchReviews(with ngoID: String){
        
        DataBaseService.fetchAllNGOReviews(with: ngoID) { (error, ngoReviews) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error: \(error.localizedDescription)")
            } else if let ngoReviews = ngoReviews {
                self.allNGOReviews.append(ngoReviews)
            }
        }
    }
    
    private func writeReviewOnNGO(){
        
        guard let reviewer = authService.getCurrentVConnectUser() else {
            showAlert(title: "Error", message: "Only logged in users can leave a review")
            return
            
        }
        
        guard let review = nGOsDetailView.reviewView.reviewTextField.text, !review.isEmpty else {
            self.showAlert(title: "Error", message: "Cannot post empty review")
            return
        }
        
        
        
        DataBaseService.createReview(on: nGO.ngOID, reviewerID: reviewer.uid, with: review) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while posting review on NGO")
            } else {
                self.showAlert(title: "Success", message: "Thank you for leaving a review on this NGO")
            }
        }
    }
    
    private func setUpPostButton(){
        nGOsDetailView.reviewView.sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        
    }
    
    @objc private func sendButtonPressed(){
        writeReviewOnNGO()
    }

}

extension NGODetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nGO.ngoImagesURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NGOPhotosCollectionViewCell", for: indexPath) as? NGOPhotosCollectionViewCell else {return UICollectionViewCell()}
        
        let ngoImages = nGO.ngoImagesURL
        let image = ngoImages[indexPath.row]
        fetchNGOImages(photoURL: image.pictureUrl, photoCell: photoCell)
        return photoCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.4889, height: collectionView.frame.size.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension NGODetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNGOReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reviewsCell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else {return UITableViewCell()}
        let review = allNGOReviews[indexPath.row]
        fetchReviewer(with: review.reviewerID, reviewCell: reviewsCell)
        reviewsCell.reviewTextView.text = review.review
        reviewsCell.reviewDate.text = review.date
        reviewsCell.backgroundColor = .clear
        
        return reviewsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
