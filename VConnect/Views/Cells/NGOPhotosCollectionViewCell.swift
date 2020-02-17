//
//  NGOPhotosCollectionViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/31/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOPhotosCollectionViewCell: UICollectionViewCell {
    
    public lazy var ngoPhotoView: UIImageView = {
        let ngoPhoto = UIImageView()
        ngoPhoto.contentMode = .scaleToFill
        return ngoPhoto
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInt()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInt()
    }
    private func commonInt(){
        setNGOPhotoImageViewConstrains()
    }
    private func setNGOPhotoImageViewConstrains(){
        addSubview(ngoPhotoView)
    ngoPhotoView.translatesAutoresizingMaskIntoConstraints = false
    ngoPhotoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    ngoPhotoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    ngoPhotoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    ngoPhotoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    }
    
//    public func setNGOImage(withNGOImage imageURL: String) {
//
//        ImageHelper.fetchImage(urlString: imageURL) { (error, ngoImage) in
//            if error != nil {
//                self.show
//            }
//        }
//
//    }
    
//    private func fetchNGOImages(photoURL: String, photoCell: NGOPhotosCollectionViewCell){
//        ImageHelper.fetchImage(urlString: photoURL) { (error, image) in
//            if error != nil {
//                self.showAlert(title: "Error", message: "Error: Can't load NGO images")
//            } else if let image = image {
//                photoCell.ngoPhotoView.image = image
//
//            }
//        }
//
//    }
}
