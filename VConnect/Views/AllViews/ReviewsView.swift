//
//  ReviewsView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/29/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class ReviewsView: UIView {
    
    public lazy var reviewsTableView: UITableView = {
        let reviewsTableView = UITableView()
        
        return reviewsTableView
    }()
    
    public lazy var reviewTextField: UITextField = {
        let reviewTextField = UITextField()
        reviewTextField.placeholder = "Write a review here"
        reviewTextField.backgroundColor = .red
        return reviewTextField
    }()
    
    public lazy var sendButton: UIButton = {
        let sendButton = UIButton()
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = UIColor.init(hexString: "033860")
       // sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        sendButton.layer.cornerRadius = 10
        sendButton.isUserInteractionEnabled = true 
        return sendButton
    }()

    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        self.reviewsTableView.register(ReviewsTableViewCell.self, forCellReuseIdentifier: "ReviewsTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setConstrains()
    }
    
    private func setConstrains(){
        setReviewsTableViewConstrains()
        setReviewsTextFieldConstrains()
        setSendButtonConstrains()
        
    }
    

    private func setReviewsTableViewConstrains(){
        addSubview(reviewsTableView)
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        reviewsTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        reviewsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        reviewsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        reviewsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        
    }
    
    private func setReviewsTextFieldConstrains(){
        addSubview(reviewTextField)
        reviewTextField.translatesAutoresizingMaskIntoConstraints = false
        reviewTextField.topAnchor.constraint(equalTo: reviewsTableView.bottomAnchor).isActive = true
        reviewTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        reviewTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        reviewTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
    }
    
    private func setSendButtonConstrains(){
        reviewTextField.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: reviewTextField.bottomAnchor, constant: 0).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 300).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    

    @objc public func sendButtonPressed(){
        print("Send button pressed")
        
    }
    
    
    
    

}
