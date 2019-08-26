//
//  NGOsTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import Cosmos


class NGOsTableViewCell: UITableViewCell {
    
    public lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private lazy var designView: UIView = {
        let designView = UIView()
        designView.backgroundColor = UIColor.init(hexString: "0072B1")
        //designView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return designView
    }()
    
    public lazy var nGOName: UILabel = {
        let nGOName = UILabel()
        nGOName.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        nGOName.textColor = .white
        nGOName.numberOfLines = 0
        nGOName.textAlignment = .left
        return nGOName
    }()
    
    public lazy var nGOCity: UILabel = {
        let nGOCity = UILabel()
        nGOCity.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        nGOCity.textColor = UIColor.init(hexString: "fa9805")
        nGOCity.numberOfLines = 0
        nGOCity.textAlignment = .right
        return nGOCity
    }()
    
    
    public lazy var nGOMiles: UILabel = {
        let nGOMiles = UILabel()
        nGOMiles.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        nGOMiles.text = "1mile"
        nGOMiles.textColor = UIColor.init(hexString: "fa9805")
        nGOMiles.textAlignment = .right
        nGOMiles.numberOfLines = 0
        return nGOMiles
    }()
    
    public lazy var rating: UILabel = {
        let rating = UILabel()
        rating.text = "Rating"
        rating.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        rating.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return rating
    }()

    public lazy var cosmosView: CosmosView = {
        var ratingsView = CosmosView()
        return ratingsView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        contentView.frame.inset(by: margins)

        
    }

    private func commonInit(){
        setTableViewConstrains()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 17
        containerView.layer.shadowOpacity = 0.9
        containerView.layer.borderColor = UIColor.init(hexString: "033860")?.cgColor
        containerView.layer.borderWidth = 1
        //containerView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    private func setTableViewConstrains(){
        setContainerViewConstrains()
        setDesignViewConstrains()
        setNameLabelConstrains()

        setRatingsViewContrains()
        setCityLabelConstrains()
        setMilesLabelConstrains()
       
   
    }
    
    private func setDesignViewConstrains(){
        containerView.addSubview(designView)
        designView.translatesAutoresizingMaskIntoConstraints = false
        designView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
         designView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
         designView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        designView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.78).isActive = true        
    }
    
    
    private func setContainerViewConstrains(){
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func setNameLabelConstrains(){
        designView.addSubview(nGOName)
        nGOName.translatesAutoresizingMaskIntoConstraints = false
        nGOName.topAnchor.constraint(equalTo: designView.topAnchor, constant: 1).isActive = true
        nGOName.leadingAnchor.constraint(equalTo: designView.leadingAnchor, constant: 10).isActive = true
        nGOName.widthAnchor.constraint(equalTo: designView.widthAnchor, multiplier: 0.65).isActive = true
    }
    
    private func setRatingsViewContrains(){
        designView.addSubview(cosmosView)
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        cosmosView.topAnchor.constraint(equalTo: nGOName.bottomAnchor, constant: 0).isActive = true
        cosmosView.leadingAnchor.constraint(equalTo: designView.leadingAnchor, constant: 5).isActive = true
        cosmosView.widthAnchor.constraint(equalTo: designView.widthAnchor, multiplier: 0.65).isActive = true
        cosmosView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
 
    

    private func setCityLabelConstrains(){
        containerView.addSubview(nGOCity)
        nGOCity.translatesAutoresizingMaskIntoConstraints = false
        nGOCity.topAnchor.constraint(equalTo: cosmosView.bottomAnchor, constant: 10).isActive = true
        nGOCity.leadingAnchor.constraint(equalTo: designView.leadingAnchor).isActive = true
        nGOCity.trailingAnchor.constraint(equalTo: designView.trailingAnchor, constant: -12).isActive = true
        //nGOCity.bottomAnchor.constraint(equalTo: designView.bottomAnchor, constant: -30).isActive = true
        
        
      
    }

    private func setMilesLabelConstrains(){
        containerView.addSubview(nGOMiles)
        nGOMiles.translatesAutoresizingMaskIntoConstraints = false
        nGOMiles.topAnchor.constraint(equalTo: nGOCity.bottomAnchor, constant: 3).isActive = true
        nGOMiles.leadingAnchor.constraint(equalTo: designView.leadingAnchor).isActive = true
        nGOMiles.trailingAnchor.constraint(equalTo: designView.trailingAnchor, constant: -12).isActive = true
        nGOMiles.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true

    }

}
