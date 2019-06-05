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
        
    }

}

extension NGODetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NGOPhotosCollectionViewCell", for: indexPath) as? NGOPhotosCollectionViewCell else {return UICollectionViewCell()}
        
        let imageName = namesOfImages[indexPath.row]
        photoCell.ngoPhotoView.image = UIImage.init(named: imageName)
        
        photoCell.layer.cornerRadius = 1
        photoCell.layer.borderWidth = 1
        photoCell.layer.borderColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0)
        
        return photoCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.35, height: collectionView.frame.size.height * 0.5)
    }
    
}
