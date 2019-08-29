//
//  ReviewsTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/29/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import Cosmos

class ReviewsTableViewCell: UITableViewCell {
    
    public lazy var reviewerProfileImage: UIImageView = {
        let reviewerProfileImage = UIImageView()
        reviewerProfileImage.backgroundColor = UIColor.lightGray
        reviewerProfileImage.isUserInteractionEnabled = true 
       return reviewerProfileImage
    }()
    
    public lazy var reviewerName: UILabel = {
        let reviewerName = UILabel()
        reviewerName.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        reviewerName.textColor = UIColor.init(hexString: "0072B1")
        return reviewerName
    }()
    
    public lazy var reviewTextView: UITextView = {
        let reviewTextView = UITextView()
        reviewTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        reviewTextView.backgroundColor = .clear 
        reviewTextView.textColor = UIColor.init(hexString: "0072B1")
        reviewTextView.isEditable = false
        reviewTextView.isSelectable = false
        reviewTextView.isUserInteractionEnabled = false
        return reviewTextView
    }()
    
    public lazy var reviewDate: UILabel = {
        let reviewDate = UILabel()
        reviewDate.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        reviewDate.textColor = UIColor.init(hexString: "0072B1")
        return reviewDate
    }()
    
    
    public lazy var cosmosView: CosmosView = {
        var ratingsView = CosmosView()
        ratingsView.settings.updateOnTouch = false
        ratingsView.settings.totalStars = 5
        ratingsView.settings.fillMode = .half
        return ratingsView
    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        reviewerProfileImage.contentMode = .scaleAspectFill
        reviewerProfileImage.layer.cornerRadius = reviewerProfileImage.frame.size.width/2
        reviewerProfileImage.layer.masksToBounds = false
        reviewerProfileImage.layer.borderColor = UIColor.lightGray.cgColor
        reviewerProfileImage.layer.borderWidth = 1
        reviewerProfileImage.clipsToBounds = true 
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        self.selectionStyle = .none 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    private func commonInit(){
        setConstrains()
 
    }
    
    private func setConstrains(){
        setImageViewConstrains()
        setReviewerNameConstrains()
        setDateLabelConstrains()
        setRatingsViewConstrains()
        setReviewTextViewConstrains()
        
    }
    
    private func setImageViewConstrains(){
        addSubview(reviewerProfileImage)
        reviewerProfileImage.translatesAutoresizingMaskIntoConstraints = false
        reviewerProfileImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        reviewerProfileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        reviewerProfileImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1).isActive = true
        reviewerProfileImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1).isActive = true
    }
    
    public func setReviewerNameConstrains(){
        addSubview(reviewerName)
        reviewerName.translatesAutoresizingMaskIntoConstraints = false
        reviewerName.topAnchor.constraint(equalToSystemSpacingBelow: reviewerProfileImage.topAnchor, multiplier: 1).isActive = true
        reviewerName.leadingAnchor.constraint(equalToSystemSpacingAfter: reviewerProfileImage.trailingAnchor, multiplier: 2).isActive = true
        reviewerName.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        reviewerName.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
    public func setDateLabelConstrains(){
        addSubview(reviewDate)
        reviewDate.translatesAutoresizingMaskIntoConstraints = false
        reviewDate.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        reviewDate.leadingAnchor.constraint(equalToSystemSpacingAfter: reviewerName.trailingAnchor, multiplier: 0.5).isActive = true
        reviewDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        reviewDate.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06).isActive = true
    }
    
    private func setRatingsViewConstrains(){
        addSubview(cosmosView)
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        cosmosView.topAnchor.constraint(equalTo: reviewerProfileImage.bottomAnchor, constant: 10).isActive = true
        cosmosView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        cosmosView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.6).isActive = true
        cosmosView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
    public func setReviewTextViewConstrains(){
        addSubview(reviewTextView)
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.topAnchor.constraint(equalTo: cosmosView.bottomAnchor).isActive = true
        reviewTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        reviewTextView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        reviewTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    

 

}
