//
//  NGOsDetailView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/31/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsDetailView: UIView {
    
    public var ngoPhotosView: NGOPhotosView = {
        let ngoPhotosView = NGOPhotosView()
        return ngoPhotosView
    }()
    
    public var ngoAddressView: HoursAndAddressView = {
        let ngoAddressView = HoursAndAddressView()
        return ngoAddressView
    }()
    
    public lazy var reviewView: ReviewsView = {
        let reviewView = ReviewsView()
        reviewView.backgroundColor = .white
        return reviewView
    }()
    
    public lazy var detailsViewScrollView: UIScrollView = {

        let scrollView = UIScrollView()
        scrollView.contentSize.height = 800
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    
    public lazy var nGODescription: UITextView = {
        let nGODescription = UITextView()
        nGODescription.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        nGODescription.textColor = .white
        nGODescription.textAlignment = .center
        nGODescription.backgroundColor = .clear
        nGODescription.isEditable = false
        nGODescription.isSelectable = false
        nGODescription.isScrollEnabled =  false
        return nGODescription
    }()

    public lazy var nGOWebsite: UITextView = {
        let website = UITextView()
        website.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        website.textColor = .white
        website.textAlignment = .center
        website.backgroundColor = .clear
        website.isEditable = false
        website.isSelectable = false
        website.dataDetectorTypes = UIDataDetectorTypes.link
        website.isScrollEnabled =  false
        return website
    }()

    public lazy var viewsSegmentedControl: UISegmentedControl = {
        let viewsSegmentedControl = UISegmentedControl()
        viewsSegmentedControl.insertSegment(withTitle: "Photos", at: 0, animated: true)
        viewsSegmentedControl.insertSegment(withTitle: "Address and Hours", at: 1, animated: true)
        viewsSegmentedControl.insertSegment(withTitle: "Reviews", at: 2, animated: true)
        viewsSegmentedControl.selectedSegmentIndex = 0
        viewsSegmentedControl.tintColor = .white
        viewsSegmentedControl.addTarget(self, action: #selector(setToggledViewConstrains), for: .valueChanged)
        return viewsSegmentedControl

    }()
    
    public lazy var toggledView: UIView = {
        let toggledView = UIView()
        return toggledView
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
        setupPhotosViewConstrains()
        
    }
    
    private func setConstrains(){
        setUpScrollViewConstrains()
        setDescriptionConstrains()
         setNGOWebsiteTextViewConstrains()
        setViewsSegmentedControlConstrains()
    }
    
    private func setUpScrollViewConstrains(){
        addSubview(detailsViewScrollView)
        detailsViewScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsViewScrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        detailsViewScrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        detailsViewScrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        detailsViewScrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setDescriptionConstrains(){
        detailsViewScrollView.addSubview(nGODescription)
        nGODescription.translatesAutoresizingMaskIntoConstraints = false
        nGODescription.topAnchor.constraint(equalTo: detailsViewScrollView.topAnchor, constant: 5).isActive = true
        nGODescription.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 5).isActive = true
        nGODescription.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: -5).isActive = true
        nGODescription.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }

    private func setNGOWebsiteTextViewConstrains(){
        detailsViewScrollView.addSubview(nGOWebsite)
        nGOWebsite.translatesAutoresizingMaskIntoConstraints = false
        nGOWebsite.topAnchor.constraint(equalTo: nGODescription.bottomAnchor, constant: 5).isActive = true
        nGOWebsite.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nGOWebsite.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        nGOWebsite.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setViewsSegmentedControlConstrains(){
        detailsViewScrollView.addSubview(viewsSegmentedControl)
        viewsSegmentedControl.selectedSegmentIndex = 0
        viewsSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        viewsSegmentedControl.topAnchor.constraint(equalTo: nGOWebsite.bottomAnchor, constant: 5).isActive = true
        viewsSegmentedControl.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        viewsSegmentedControl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        viewsSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupPhotosViewConstrains(){
        ngoAddressView.removeFromSuperview()
        reviewView.removeFromSuperview()
        detailsViewScrollView.addSubview(ngoPhotosView)
        ngoPhotosView.translatesAutoresizingMaskIntoConstraints = false
        ngoPhotosView.topAnchor.constraint(equalTo: viewsSegmentedControl.bottomAnchor, constant: 2).isActive = true
        ngoPhotosView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        ngoPhotosView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        ngoPhotosView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupAddressViewConstrains(){
        ngoPhotosView.removeFromSuperview()
        reviewView.removeFromSuperview()
        detailsViewScrollView.addSubview(ngoAddressView)
        ngoAddressView.translatesAutoresizingMaskIntoConstraints = false
        ngoAddressView.topAnchor.constraint(equalTo: viewsSegmentedControl.bottomAnchor, constant: 2).isActive = true
        ngoAddressView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        ngoAddressView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        ngoAddressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setReviewConstrains(){
        ngoPhotosView.removeFromSuperview()
        ngoAddressView.removeFromSuperview()
        detailsViewScrollView.addSubview(reviewView)
        reviewView.translatesAutoresizingMaskIntoConstraints = false
        reviewView.topAnchor.constraint(equalTo: viewsSegmentedControl.bottomAnchor, constant: 2).isActive = true
        reviewView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        reviewView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        reviewView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
     @objc public func setToggledViewConstrains(){
        switch viewsSegmentedControl.selectedSegmentIndex {
        case 0:
            setupPhotosViewConstrains()
        case 1:
            setupAddressViewConstrains()
        case 2:
            setReviewConstrains()
        default:
            return
        }
        
        
    }
    
    

}
