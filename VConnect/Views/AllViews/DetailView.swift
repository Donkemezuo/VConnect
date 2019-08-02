//
//  DetailView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class DetailView: UIView {

    public lazy var ngoPhotosView: NGOPhotosView = {
        let ngoPhotosView = NGOPhotosView()
        //ngoPhotosView.backgroundColor = .red
        return ngoPhotosView
    }()
    
    public lazy var missionView: NGOMissionView = {
        let missionView = NGOMissionView()
        //missionView.backgroundColor = .green
        return missionView
    }()
    
    public var ngoAddressView: HoursAndAddressView = {
        let ngoAddressView = HoursAndAddressView()
        //ngoAddressView.backgroundColor = .blue
        return ngoAddressView
    }()
    
    public lazy var reviewView: ReviewsView = {
        let reviewView = ReviewsView()
        //reviewView.backgroundColor = .gray
        reviewView.backgroundColor = .white
        return reviewView
    }()
    
    public lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    
    private lazy var containView: UIView = {
        let containView = UIView()
        containView.backgroundColor = UIColor.init(hexString: "0072B1")
        return containView
        
    }()
    
    public lazy var moreOptionsButton: UIButton = {
        let moreOptionsButton = UIButton()
        moreOptionsButton.setTitle("...", for: .normal)
        moreOptionsButton.setTitleColor(.white, for: .normal)
        moreOptionsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        return moreOptionsButton
    }()
    
    public lazy var canCelView: UIButton = {
        
        let canCelView = UIButton()
        canCelView.setImage(#imageLiteral(resourceName: "icons8-delete_sign_filled.png").withRenderingMode(.alwaysTemplate), for: .normal)
        
        canCelView.tintColor = UIColor.white
        return canCelView
        
    }()
    
    public lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        
        textLabel.text = "VConnect"
        textLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        
        return textLabel
    }()
    
    public lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Mission", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Address", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Reviews", at: 2, animated: true)
        segmentedControl.insertSegment(withTitle: "Photo Gallery", at: 3, animated: true)
        segmentedControl.tintColor = .white
        //segmentedControl.addTarget(self, action: #selector(setSegmentedControlToggled), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
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
        setContainerViewConstrains()
        setSettingsButtonConstrains()
        setTxtLabelConstrains()
        setMoreOptionsButton()
        setSegmentedControlConstrains()
        setContentViewConstrains()
    }
    
    private func setContainerViewConstrains(){
        addSubview(containView)
        containView.translatesAutoresizingMaskIntoConstraints = false
        containView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        containView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        containView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    
    private func setSettingsButtonConstrains(){
        containView.addSubview(canCelView)
        canCelView.translatesAutoresizingMaskIntoConstraints = false
        //settingButton.topAnchor.constraint(equalTo: containView.topAnchor, constant: 30).isActive = true
        canCelView.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 10).isActive = true
        canCelView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        canCelView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        canCelView.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -10).isActive = true
    }

    
    private func setTxtLabelConstrains(){
        containView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        // textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: canCelView.trailingAnchor, constant: 50).isActive = true
        //textLabel.trailingAnchor.constraint(equalTo: containView.trailingAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setMoreOptionsButton(){
        containView.addSubview(moreOptionsButton)
        moreOptionsButton.translatesAutoresizingMaskIntoConstraints = false
        moreOptionsButton.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 10).isActive = true
        moreOptionsButton.trailingAnchor.constraint(equalTo: containView.trailingAnchor).isActive = true
        moreOptionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        moreOptionsButton.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -17).isActive = true
    }
    
    private func setSegmentedControlConstrains(){
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false 
        segmentedControl.topAnchor.constraint(equalTo: containView.bottomAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setContentViewConstrains(){
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2).isActive = true
        containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public func setMissionViewConstrains(){
        ngoPhotosView.removeFromSuperview()
        ngoAddressView.removeFromSuperview()
        reviewView.removeFromSuperview()
        containerView.addSubview(missionView)
        missionView.translatesAutoresizingMaskIntoConstraints = false
        missionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2).isActive = true
        missionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        missionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        missionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }
    
    public func setAddressViewConstrains(){
        ngoPhotosView.removeFromSuperview()
        missionView.removeFromSuperview()
        reviewView.removeFromSuperview()
        containerView.addSubview(ngoAddressView)
        ngoAddressView.translatesAutoresizingMaskIntoConstraints = false
        ngoAddressView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2).isActive = true
        ngoAddressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        ngoAddressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        ngoAddressView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    public func setReviewsViewConstrains(){
        ngoPhotosView.removeFromSuperview()
        missionView.removeFromSuperview()
        ngoAddressView.removeFromSuperview()
        containerView.addSubview(reviewView)
        reviewView.backgroundColor = .white
        reviewView.translatesAutoresizingMaskIntoConstraints = false
        reviewView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2).isActive = true
        reviewView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        reviewView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        reviewView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    public func setPhotoViewConstrains(){
        missionView.removeFromSuperview()
        ngoAddressView.removeFromSuperview()
        reviewView.removeFromSuperview()
        containerView.addSubview(ngoPhotosView)
        ngoPhotosView.translatesAutoresizingMaskIntoConstraints = false
        ngoPhotosView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2).isActive = true
        ngoPhotosView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        ngoPhotosView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        ngoPhotosView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
//    @objc public func setSegmentedControlToggled(){
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//       setMissionViewConstrains()
//        case 1:
//       setAddressViewConstrains()
//
//        case 2:
//       setReviewsViewConstrains()
//        case 3:
//        setPhotoViewConstrains()
//        default:
//            return
//
//        }
//    }

    
     
    
}
