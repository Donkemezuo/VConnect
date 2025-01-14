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
import GoogleMaps
import MessageUI
import FirebaseAuth
import FirebaseFirestore

protocol DetailVCDelegate: AnyObject {
    func didBookMarkedNGO(withBookMarkedIDs: [BookMark])
}

class NGODetailsViewController: UIViewController {
    private var leftSwipeGesture: UISwipeGestureRecognizer!
    private var rightSwipeGesture: UISwipeGestureRecognizer!
    var userLocationCoordinates: CLLocationCoordinate2D!
    var ngoLocationCoordinates: CLLocationCoordinate2D!
    var vconnectUser: VConnectUser?
    private var tapGesture: UITapGestureRecognizer!
    private var detailView = DetailView()
    private var backgroundView = TableViewBackgroundImageView()
    private var nGO: NGO!
    var ngoRatingsValue = 0.0
    private var barButtonItem = UIBarButtonItem()
    private var allNGOReviews = [NGOReviews]() {
        didSet {
            DispatchQueue.main.async {
                self.detailView.reviewView.reviewsTableView.reloadData()
                self.detailView.configureEmptyState(withReviews: self.allNGOReviews)
            }
        }
    }
    
    weak var detailVCDelegate: DetailVCDelegate?
    let customView = CosmosView()
    
    private var allUserBookMarks = [BookMark]()
    private var cellSpacing = UIScreen.main.bounds.size.width * 0.001
    private var reportUserTapGesture: UITapGestureRecognizer!
    
    private var numberOfRaters = 1.0
    private var viewUI = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "0072B1")
        view.addSubview(detailView)
        detailView.ngoPhotosView.nGOPhotosCollectionView.delegate = self
        detailView.ngoPhotosView.nGOPhotosCollectionView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true 
        detailView.reviewView.reviewsTableView.delegate = self
        detailView.reviewView.reviewsTableView.dataSource = self
        detailView.setNGOInformations(withNGO: self.nGO)
        fetchReviews(with: nGO.ngOID)
        setUpPostReviewsButton()
        swipeView()
        dismissView()
        detailView.ngoAddressView.googleMapView.delegate = self
        bookMarkButton()
        setupSafariServices()
        segmentedControlTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailView.reviewView.reviewsTableView.estimatedRowHeight = 5
        detailView.reviewView.reviewsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func segmentedControlTapped(){
        detailView.segmentedControl.addTarget(self, action: #selector(configureSegmentedControl), for: .valueChanged)
        configureSegmentedControl()
    }
    
    @objc private func configureSegmentedControl(){
        switch detailView.segmentedControl.selectedSegmentIndex {
        case 0:
            detailView.setMissionViewConstrains()
        case 1:
            detailView.setAddressViewConstrains()
            self.setupGoodMapView(withLatitude: ngoLocationCoordinates.latitude, withLogitude: ngoLocationCoordinates.longitude)
        case 2:
            detailView.setReviewsViewConstrains()
        case 3:
            detailView.setPhotoViewConstrains()
        default:
            return
        }
    }
    
    private func swipeView(){
        leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swippedLeft(_:)))
        leftSwipeGesture.direction = .left
        rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight(_:)))
        rightSwipeGesture.direction = .right
        
        self.detailView.containerView.addGestureRecognizer(leftSwipeGesture)
        self.detailView.containerView.addGestureRecognizer(rightSwipeGesture)
        
    }
    
    @objc private func swippedLeft(_ sender: UISwipeGestureRecognizer){
        
        if detailView.segmentedControl.selectedSegmentIndex == 3 {
            detailView.segmentedControl.selectedSegmentIndex = 0
            segmentedControlTapped()

        
        } else {
            detailView.segmentedControl.selectedSegmentIndex += 1
            segmentedControlTapped()
            if detailView.segmentedControl.selectedSegmentIndex == 1 {
                self.setupGoodMapView(withLatitude: ngoLocationCoordinates.latitude, withLogitude: ngoLocationCoordinates.longitude)
            }
        }
    }
    
    @objc private func swipedRight(_ sender: UISwipeGestureRecognizer) {
        
        if detailView.segmentedControl.selectedSegmentIndex == 0 {
            detailView.segmentedControl.selectedSegmentIndex = 3
            segmentedControlTapped()
        } else {
            detailView.segmentedControl.selectedSegmentIndex -= 1
            segmentedControlTapped()
        }
    }
    
    init(nGO: NGO, userLocationCoordinate: CLLocationCoordinate2D, ngoCoordinates: CLLocationCoordinate2D, bookMarkIDs: [BookMark]) {
        super.init(nibName: nil, bundle: nil)
        self.nGO = nGO
        self.detailView.configureEmptyState(withReviews: self.allNGOReviews)
        self.ngoLocationCoordinates = ngoCoordinates
        self.userLocationCoordinates = userLocationCoordinate
        self.allUserBookMarks = bookMarkIDs
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func dismissView(){
        detailView.canCelView.addTarget(self, action: #selector(dismisButtonPressed), for: .touchUpInside)
    }
    
    @objc private func dismisButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setupSafariServices(){
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(showSafariView))
        detailView.missionView.websiteTxtView.addGestureRecognizer(tapGesture)
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
    
    private func reportButtonPressed(){
        if MFMailComposeViewController.canSendMail(){
            let emailComposer = MFMailComposeViewController()
            emailComposer.mailComposeDelegate = self
            emailComposer.setSubject("Reporting \(vconnectUser!.lastName + " " + vconnectUser!.firstName)")
            emailComposer.setToRecipients(["trdonkemezuojnr@yahoo.com", "trdonkemezuojnr@gmail.com"])
            self.present(emailComposer, animated: true)
        } else {
            showAlert(title: "Error", message: "Email is not configured in setting. Go to settings on your device and authorize emailing")
        }
    }

    
    private func reportVConnectUser(fromReviewCell reviewCell: ReviewsTableViewCell){
        reportUserTapGesture = UITapGestureRecognizer(target: self, action: #selector(reviewerImageTap))
        reviewCell.reviewerProfileImage.addGestureRecognizer(reportUserTapGesture)
    }
    
    @objc private func reviewerImageTap(sender: AnyObject){
    
     let alertController = UIAlertController(title: "Options", message: "You can report reviewer", preferredStyle: .actionSheet)
    
        let cancel = UIAlertAction(title: "Cancel", style: .default) {(alert) in
            print("Cancel")
            }
    let reportUser = UIAlertAction(title: "Report VConnectUser", style: .destructive) { (alert) in
        print("This takes you to an email")
        self.reportButtonPressed()
        
    }
    
    alertController.addAction(cancel)
    alertController.addAction(reportUser)
    if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
    present(alertController, animated: true)
    }
    
    private func bookMarkButton() {
        detailView.moreOptionsButton.addTarget(self, action: #selector(showAlertController), for: .touchUpInside)
    }
    
    
    private func bookMarkNGO(onVConnectUserID userID: String){
        let bookMark = BookMark(ngoID: self.nGO.ngOID, date: Date.customizedDateFormat())
        if !allUserBookMarks.contains(bookMark){
            DataBaseService.createBookMark(onVConnectUserID: userID, bookMarkNGO: bookMark) { (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                self.showAlert(title: "BookMarked", message: "Successfully BookMarked NGO. This NGO will appear on your profile", handler: { (okay) in
          self.detailVCDelegate?.didBookMarkedNGO(withBookMarkedIDs: self.allUserBookMarks)
                    self.allUserBookMarks.append(bookMark)
                    })
                }
            }
        } else {
            self.showAlert(title: "Error", message: "You have already book marked this NGO before. It's on your profile")
        }
    }
    
    
    @objc private func showAlertController(sender: AnyObject){
        let alertController = UIAlertController(title: "Options", message: "You can book mark an NGO to view later", preferredStyle: .actionSheet)
        let bookMark = UIAlertAction(title: "Bookmark", style: .default) { (alert) in
            if Auth.auth().currentUser == nil {
                self.showLoginViewFromBookmark(sender: sender)
            } else {
                guard let userID = Auth.auth().currentUser else {return}
                self.bookMarkNGO(onVConnectUserID: userID.uid)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
        }
        
        alertController.addAction(bookMark)
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true)
    }
    
    private func showLoginViewFromBookmark(sender: AnyObject){
        let alertController = UIAlertController(title: "Error", message: "Only registered users can bookmark", preferredStyle: .actionSheet)
        let bookmark = UIAlertAction(title: "SignIn or SignUp", style: .default) { (bookmark) in
            let storyboard = UIStoryboard(name: "AuthenticationView", bundle: nil)
            let signInView = storyboard.instantiateViewController(withIdentifier: "SignInView") as! SignInViewController
            signInView.userSignInState = .bookmark
            signInView.nGOID = self.nGO.ngOID
            signInView.bookMarkDelegate = self
            let signInNav = UINavigationController(rootViewController: signInView)
            self.present(signInNav, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
        }
        alertController.addAction(bookmark)
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true)
    }
    
    private func showLoginViewFromReview(sender: AnyObject){
    let alertController = UIAlertController(title: "Error", message: "Only signed in users can leave a review", preferredStyle: .actionSheet)
        let signIn = UIAlertAction(title: "SignIn or SignUp", style: .default) { (bookmark) in
            let storyboard = UIStoryboard(name: "AuthenticationView", bundle: nil)
            let signInView = storyboard.instantiateViewController(withIdentifier: "SignInView") as! SignInViewController
            signInView.userSignInState = .review
            signInView.nGOID = self.nGO.ngOID
            signInView.bookMarkDelegate = self
            let signInNav = UINavigationController(rootViewController: signInView)
            self.present(signInNav, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
        }
        alertController.addAction(signIn)
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true)
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
                self.vconnectUser = reviewer
                }
               
            }
        }
    }
    
    private func showPin(pinPosition: CLLocationCoordinate2D){
        let pin = GMSMarker()
        pin.position = pinPosition
        pin.title = nGO.ngoStreetAddress
        pin.snippet = nGO.ngoCity
        pin.map = detailView.ngoAddressView.googleMapView
    }

    
    private func setupGoodMapView( withLatitude lat: CLLocationDegrees, withLogitude long: CLLocationDegrees){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 16)
        detailView.ngoAddressView.googleMapView.camera = camera
        self.showPin(pinPosition: detailView.ngoAddressView.googleMapView.camera.target)
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
    
    private func writeReviewOnNGO(withA ratingsValue: Double){
   
        guard let review = detailView.reviewView.reviewTextField.text, !review.isEmpty else {
            self.showAlert(title: "Error", message: "Cannot post empty review")
            return
        }
        
        guard let reviewer = Auth.auth().currentUser else {
            self.showLoginViewFromReview(sender: self)
            return
        }
        DataBaseService.createReview(on: nGO.ngOID, reviewerID: reviewer.uid, with: review, withA: ratingsValue) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while posting review on NGO")
            } else {
                
    self.showAlert(title: "Successfully posted review", message: "Thank you for leaving a review on this organization")
                self.detailView.reviewView.reviewTextField.text = ""
            }
        }
    }
    
    private func presentRatingView(){
        let alertController = UIAlertController(title: "Rate Experience", message: "Please rate your experience", preferredStyle: .alert)
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
            self.ngoRatingsValue = (self.nGO.ratingsValue + self.customView.rating) / self.numberOfRaters
            
    DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(self.nGO.ngOID).updateData([NGOsCollectionKeys.ratingsValue: self.ngoRatingsValue])

            self.writeReviewOnNGO(withA: self.customView.rating)
            
        }
        alertController.addAction(thankYou)
        present(alertController, animated: true)
        
    }
    
    private func setUpPostReviewsButton(){
        detailView.reviewView.sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    @objc private func sendButtonPressed(){
        self.presentRatingView()
    }
    
    private func segueToMap(){
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.open(NSURL(string: "comgooglemaps://?saddr=&daddr=\(ngoLocationCoordinates.latitude),\(ngoLocationCoordinates.longitude)&directionsmode=driving")! as URL)
        } else {
            NSLog("Can't use comgooglemaps://");
        }
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
        if allNGOReviews.count > 0 {
            
            guard let reviewsCell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else {return UITableViewCell()}
            let review = allNGOReviews[indexPath.row]
            fetchReviewer(with: review.reviewerID, reviewCell: reviewsCell)
            reportVConnectUser(fromReviewCell: reviewsCell)
            reviewsCell.reviewTextView.text = review.review
            reviewsCell.cosmosView.rating = review.ratingValue
            reviewsCell.reviewDate.text = review.date
            reviewsCell.backgroundColor = .clear
            
            return reviewsCell
            
        } else {
           return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension NGODetailsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        segueToMap()
    }
}

extension NGODetailsViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            controller.showAlert(title: "Thank you", message: "Thank you for reporting \(vconnectUser!.firstName + " " + vconnectUser!.lastName). As a support community, we value and respect the safety of our users and will continue to work towards creating a platform where people and organizations feel safe") { (alert) in
                            controller.dismiss(animated: true, completion: nil)
        }
        } else {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}


extension NGODetailsViewController: VConnectusersignInDelegate {
    func createReview() {
        guard let userID = Auth.auth().currentUser else {return}
        guard let reviewMessage = detailView.reviewView.reviewTextField.text, !reviewMessage.isEmpty else {return}
        DataBaseService.createReview(on: nGO.ngOID, reviewerID: userID.uid, with: reviewMessage, withA: customView.rating ) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while posting review on NGO")
            } else {
            self.showAlert(title: "Successfully posted review", message: "Thank you for leaving a review on this organization")
            self.detailView.reviewView.reviewTextField.text = ""
            }
        }
    }

    func successfullySignedIn() {
        guard let userID = Auth.auth().currentUser else {return}
        DataBaseService.fetchVConnectBookMarkedNGOs(userID.uid) { (error, bookmarks) in
                    if let error = error {
                        self.showAlert(title: "Error", message: "Error \(error.localizedDescription) encountered while fetching book marks")
                    } else if let bookmarks = bookmarks {
                        self.allUserBookMarks = bookmarks
                    }
                }
            }
    }


    



