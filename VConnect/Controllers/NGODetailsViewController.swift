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
    private var namesOfImages = ["aaa", "aids", "foods", "halfs", "food-aid-3", "longgg"]
    private var authService = AppDelegate.authService
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsDetailView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        nGOsDetailView.ngoPhotosView.nGOPhotosCollectionView.delegate = self
         nGOsDetailView.ngoPhotosView.nGOPhotosCollectionView.dataSource = self
        nGOInformations()
        setupBarButtonItem()
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
//        photoCell.layer.cornerRadius = 10
//        photoCell.layer.borderWidth = 5
//        photoCell.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        return photoCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.4889, height: collectionView.frame.size.height * 0.8)
//        let screenHeight = UIScreen.main.bounds.height
//        let screenWidth = UIScreen.main.bounds.width
//        let width = (screenWidth - (5*3))/2
//        let height = (screenHeight/screenWidth)*width
//
//        return CGSize(width: width, height: height)
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
