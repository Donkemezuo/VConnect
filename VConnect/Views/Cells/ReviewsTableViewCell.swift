//
//  ReviewsTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/29/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    public lazy var reviewerProfileImage: UIImageView = {
        let reviewerProfileImage = UIImageView()
        reviewerProfileImage.backgroundColor = UIColor.lightGray
       return reviewerProfileImage
    }()
    
    public lazy var reviewerName: UILabel = {
        let reviewerName = UILabel()
        reviewerName.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        reviewerName.textColor = .white
        return reviewerName
    }()
    
    public lazy var reviewTextView: UITextView = {
        let reviewTextView = UITextView()
        reviewTextView.font = UIFont(name: "HelveticaNeue", size: 14)
        reviewTextView.backgroundColor = .clear 
        reviewTextView.textColor = .white
        return reviewTextView
    }()
    
    public lazy var reviewDate: UILabel = {
        let reviewDate = UILabel()
        reviewDate.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        reviewDate.textColor = .white
        return reviewDate
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        setImageViewConstrains()
        setReviewerNameConstrains()
        setDateLabelConstrains()
        setReviewTextViewConstrains()
        
    }
    
    private func setImageViewConstrains(){
        addSubview(reviewerProfileImage)
        reviewerProfileImage.translatesAutoresizingMaskIntoConstraints = false
        reviewerProfileImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        reviewerProfileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        reviewerProfileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        reviewerProfileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    public func setReviewerNameConstrains(){
        addSubview(reviewerName)
        reviewerName.translatesAutoresizingMaskIntoConstraints = false
        reviewerName.centerYAnchor.constraint(equalTo: reviewerProfileImage.centerYAnchor).isActive = true
        reviewerName.leadingAnchor.constraint(equalTo: reviewerProfileImage.trailingAnchor, constant: 10).isActive = true
        reviewerName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        reviewerName.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    public func setDateLabelConstrains(){
        addSubview(reviewDate)
        reviewDate.translatesAutoresizingMaskIntoConstraints = false
        reviewDate.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        reviewDate.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 350).isActive = true
        reviewDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        reviewDate.widthAnchor.constraint(equalToConstant: 100).isActive = true
        reviewDate.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    public func setReviewTextViewConstrains(){
        addSubview(reviewTextView)
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.topAnchor.constraint(equalTo: reviewerProfileImage.bottomAnchor, constant: 5).isActive = true
        reviewTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        reviewTextView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        reviewTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    

 

}
