//
//  RateView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/2/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import Cosmos

class RateView: UIView {

  
    public lazy var smallView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return alertView
    }()
    
    public lazy var instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.text = "Please leave ratings"
        instructionLabel.textColor = .white
        instructionLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 20)
        instructionLabel.textAlignment = .center
        return instructionLabel
    }()
    
    public lazy var ratingView: CosmosView = {
        let ratingView = CosmosView()
            ratingView.settings.starMargin = 3.5
            ratingView.settings.totalStars = 5
            ratingView.settings.starSize = 55.0
            ratingView.settings.fillMode = .half
        return ratingView
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
        setLabelConstrains()
        setCosmosViewConstrains()
    }
    
    private func setConstrains(){
        addSubview(smallView)
        smallView.translatesAutoresizingMaskIntoConstraints = false
        smallView.topAnchor.constraint(equalTo: topAnchor, constant: 300).isActive = true
        smallView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300).isActive = true
        smallView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
    }
    
    private func setLabelConstrains(){
        addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.topAnchor.constraint(equalTo: smallView.topAnchor, constant: 5).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 10).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: smallView.trailingAnchor, constant: -10).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setCosmosViewConstrains(){
        addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 0).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 50).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: smallView.trailingAnchor, constant: -10).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: smallView.bottomAnchor).isActive = true
    }
    
    

}
