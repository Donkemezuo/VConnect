//
//  NGODetailsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/31/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import Cosmos
import SafariServices

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
    
    private var tapGesture: UITapGestureRecognizer!
    private var cellSpacing = UIScreen.main.bounds.size.width * 0.001
    
    private var numberOfRaters = 1.0


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
        setupSafariServices()
        

    }
    
    init(nGO: NGO) {
        super.init(nibName: nil, bundle: nil)
        self.nGO = nGO

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
    
    private func setupSafariServices(){
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(showSafariView))
        nGOsDetailView.nGOWebsite.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func showSafariView(){
        guard let website = nGO.ngoWebsite else {return }
        
        guard let websiteURL = URL(string: website) else {
            showAlert(title: "Error", message: "website URL not valid")
            return
        }
        
        let safariVC = SFSafariViewController(url: websiteURL)
        present(safariVC, animated: true)
        
        
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
        DataBaseService.fetchVConnectUserr(with: reviewerID) { (error, reviewer) in
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
                self.allNGOReviews = ngoReviews
                
            }
        }
    }
    
    private func circleImageView(cell: ReviewsTableViewCell){
        cell.reviewerProfileImage.layer.cornerRadius = cell.reviewerProfileImage.bounds.width / 2.0
        cell.reviewerProfileImage.contentMode = .scaleAspectFill
        cell.reviewerProfileImage.layer.masksToBounds = true
        cell.reviewerProfileImage.clipsToBounds = true
        
    }
    
    
    private func writeReviewOnNGO(withA ratingsValue: Double){
        
        guard let reviewer = authService.getCurrentVConnectUser() else {
            showAlert(title: "Error", message: "Only logged in users can leave a review")
            return
            
        }
        
        guard let review = nGOsDetailView.reviewView.reviewTextField.text, !review.isEmpty else {
            self.showAlert(title: "Error", message: "Cannot post empty review")
            return
        }

        DataBaseService.createReview(on: nGO.ngOID, reviewerID: reviewer.uid, with: review, withA: ratingsValue) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while posting review on NGO")
            } else {
                self.showAlert(title: "Successfully posted review", message: "Thank you for leaving a review on this organization", handler: { (alert) in
                self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    
    private func presentRatingView(){
        
        let alertController = UIAlertController(title: "Rate Experience", message: "Please rate your experience", preferredStyle: .alert)
        let customView = CosmosView()
        customView.settings.starMargin = 3.5
        customView.settings.totalStars = 5
        customView.settings.starSize = 30
        customView.settings.fillMode = .half
        alertController.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 80).isActive = true
        customView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 55).isActive = true
        customView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -50).isActive = true
        customView.widthAnchor.constraint(equalTo: alertController.view.widthAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -80).isActive = true
        let thankYou = UIAlertAction(title: "Rate", style: .default) { (alert) in
            self.numberOfRaters += 1
            let ngoRatingsValue = (self.nGO.ratingsValue + customView.rating) / self.numberOfRaters
            
            DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(self.nGO.ngOID).updateData([NGOsCollectionKeys.ratingsValue: ngoRatingsValue])

        self.writeReviewOnNGO(withA: customView.rating)
            
        }
        
        alertController.addAction(thankYou)
        present(alertController, animated: true)
        
    }
    
    
    private func setUpPostButton(){
        nGOsDetailView.reviewView.sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        
    }
    
    @objc private func sendButtonPressed(){
        self.presentRatingView()
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
          let numberOfCells: CGFloat = 2
          let numberOfSpaces: CGFloat = numberOfCells + 1
          let screenWidth = UIScreen.main.bounds.width
          let screenHeight = UIScreen.main.bounds.height
        
       return CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) / numberOfCells, height: screenHeight * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
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
        reviewsCell.cosmosView.rating = review.ratingValue
        reviewsCell.reviewDate.text = review.date
        reviewsCell.backgroundColor = .clear
        
        return reviewsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
