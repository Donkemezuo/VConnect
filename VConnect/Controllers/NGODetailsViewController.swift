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
    private var nGOsPhotoView = NGOPhotosView()
    private var nGOsAddressView = HoursAndAddressView()
    
    private var nGO: NGO!
    
    private var namesOfImages = ["aaa", "aids", "foods", "halfs", "food-aid-3", "longgg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nGOsDetailView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        nGOsPhotoView.nGOPhotosCollectionView.delegate = self
        nGOsPhotoView.nGOPhotosCollectionView.dataSource = self
        nGOInformations()
        //setSwitch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //nGOsDetailView.viewsSegmentedControl.selectedSegmentIndex = 0
        setSwitch()
    }
    
    init(nGO: NGO) {
        super.init(nibName: nil, bundle: nil)
        self.nGO = nGO
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func nGOInformations(){
        nGOsDetailView.nGONameLabel.text = nGO.ngoName
        nGOsDetailView.nGODescription.text = """
Mission:
        
     \(nGO.ngoDescription)


"""

nGOsDetailView.nGOWebsite.text = """

        \(nGO.ngoWebsite ?? "No website")

"""
        
nGOsAddressView.addressTextView.text = """
        
\(nGO.ngoStreetAddress),
        
\(nGO.ngoCity),
        
\(nGO.ngoState),
        
\(nGO.ngoZipCode)
        
"""
  
nGOsAddressView.contactInfoTextView.text = """

\(nGO.contactPersonName)
        
\(nGO.ngoEmail)
        
\(nGO.ngoPhoneNumber)


"""

nGOsAddressView.operationalHoursTextView.text = """
    
Monday:     \(nGO.mondayHours)
        
Tuesday:    \(nGO.tuesdayHours)
        
Wednesday:  \(nGO.wedsDayHours)
        
Thursday:   \(nGO.thursdayHours)
        
Friday:     \(nGO.fridayHours)
        
Saturday:   \(nGO.saturdayHours)
        
Sunday:     \(nGO.sundayHours)

"""
        
        
        
        
    }
    
    private func setSwitch(){
        nGOsDetailView.viewsSegmentedControl.addTarget(self, action: #selector(setupToggledViews), for: .valueChanged)
    }
    
    @objc private func setupToggledViews(){
        
        switch nGOsDetailView.viewsSegmentedControl.selectedSegmentIndex {
        case 0:
        nGOsDetailView.toggledView.addSubview(nGOsPhotoView)
            
        case 1:
       nGOsDetailView.toggledView.addSubview(nGOsAddressView)
        case 2:
            break
        default:
            break
        }
        
        
    }
    

}

extension NGODetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    
}
