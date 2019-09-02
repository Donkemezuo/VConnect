//
//  NGOPhotoDetailView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 8/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOPhotoDetailView: UIView {
    
    public lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.backgroundColor = .red
        locationLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        return locationLabel
    }()
    
    public lazy var ngoImageView: UIImageView = {
        let ngoImageView = UIImageView()
        return ngoImageView
    }()

    public lazy var imageCaption: UITextView = {
        let imageCaption = UITextView()
        imageCaption.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        imageCaption.backgroundColor = .green
        return imageCaption
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setConstrains()
    }
    
    private func setConstrains(){
        setLocationLabelConstrains()
        setNgoImageViewConstrains()
        setImageCaptionTxtViewConstrains()
    }
    
    private func setLocationLabelConstrains(){
        addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 0.5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
    }
    
    private func setNgoImageViewConstrains(){
        addSubview(ngoImageView)
        ngoImageView.translatesAutoresizingMaskIntoConstraints = false
        ngoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        ngoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        ngoImageView.topAnchor.constraint(equalToSystemSpacingBelow: locationLabel.bottomAnchor, multiplier: 0.1).isActive = true
        ngoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        
    }
    private func setImageCaptionTxtViewConstrains(){
        addSubview(imageCaption)
        imageCaption.translatesAutoresizingMaskIntoConstraints = false
        imageCaption.topAnchor.constraint(equalToSystemSpacingBelow: ngoImageView.bottomAnchor, multiplier: 0.1).isActive = true
        imageCaption.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageCaption.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageCaption.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    public func disPlayNgoImage(withNGOImage ngoImage: NGOImages){
        locationLabel.text = ngoImage.location
        ngoImageView.kf.setImage(with: URL(string: ngoImage.pictureUrl) , placeholder:#imageLiteral(resourceName: "sad_cloud_dark.png"))
        imageCaption.text = ngoImage.imageCaption
    }
}
