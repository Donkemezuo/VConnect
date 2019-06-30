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
    
    public lazy var nGOName: UILabel = {
        let nGOName = UILabel()
        nGOName.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        nGOName.textColor = .white
        nGOName.numberOfLines = 0
        return nGOName
    }()
    
    public lazy var nGOCity: UILabel = {
        let nGOCity = UILabel()
        nGOCity.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        nGOCity.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return nGOCity
    }()
    
    
    public lazy var nGOMiles: UILabel = {
        let nGOMiles = UILabel()
        nGOMiles.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        nGOMiles.text = "1mile"
        nGOMiles.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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

    private func commonInit(){
        setTableViewConstrains()
    }
    
    private func setTableViewConstrains(){
     setNameLabelConstrains()
     setCityLabelConstrains()
     setMilesLabelConstrains()
    setRatingsLabel()
    setRatingsViewContrains()
    }
    
    private func setNameLabelConstrains(){
        addSubview(nGOName)
        nGOName.translatesAutoresizingMaskIntoConstraints = false
        nGOName.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nGOName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nGOName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        //nGOName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    private func setCityLabelConstrains(){
        addSubview(nGOCity)
        nGOCity.translatesAutoresizingMaskIntoConstraints = false
        nGOCity.topAnchor.constraint(equalTo: nGOName.bottomAnchor, constant: 5).isActive = true
        nGOCity.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nGOCity.widthAnchor.constraint(equalToConstant: 270).isActive = true
        nGOCity.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35).isActive = true
    }
    
    private func setMilesLabelConstrains(){
        addSubview(nGOMiles)
        nGOMiles.translatesAutoresizingMaskIntoConstraints = false
        nGOMiles.topAnchor.constraint(equalTo: nGOName.bottomAnchor, constant: 5).isActive = true
        nGOMiles.leadingAnchor.constraint(equalTo: nGOCity.trailingAnchor, constant: 5).isActive = true
        nGOMiles.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        nGOMiles.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35).isActive = true
        
    }
    
    private func setRatingsLabel(){
        addSubview(rating)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.topAnchor.constraint(equalTo: nGOCity.bottomAnchor, constant: 10).isActive = true
        rating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        rating.widthAnchor.constraint(equalToConstant: 270).isActive = true
        rating.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    private func setRatingsViewContrains(){
        addSubview(cosmosView)
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        cosmosView.topAnchor.constraint(equalTo: nGOMiles.bottomAnchor, constant: 10).isActive = true
        cosmosView.leadingAnchor.constraint(equalTo: rating.trailingAnchor, constant: 5).isActive = true
        cosmosView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        cosmosView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }



}
