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
//        ngoPhoto.layer.borderWidth = 3
//        ngoPhoto.layer.cornerRadius = 15
//        ngoPhoto.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
}