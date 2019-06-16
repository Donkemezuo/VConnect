//
//  ProfileTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/10/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    public lazy var nGOName: UILabel = {
        let nGOName = UILabel()
        nGOName.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        nGOName.textColor = .white
        nGOName.numberOfLines = 0
        return nGOName
    }()
    
    public lazy var nGOCity: UILabel = {
        let nGOCity = UILabel()
        nGOCity.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        nGOCity.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return nGOCity
    }()
    
    public lazy var savedDate: UILabel = {
        let savedDate = UILabel()
        savedDate.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        //savedDate.text = "1mile"
        savedDate.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        savedDate.numberOfLines = 0
        return savedDate
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
        setSavedDateLabelConstrains()
        
    }
    
    private func setNameLabelConstrains(){
        addSubview(nGOName)
        nGOName.translatesAutoresizingMaskIntoConstraints = false
        nGOName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nGOName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nGOName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    private func setCityLabelConstrains(){
        addSubview(nGOCity)
        nGOCity.translatesAutoresizingMaskIntoConstraints = false
        nGOCity.topAnchor.constraint(equalTo: nGOName.bottomAnchor, constant: 20).isActive = true
        nGOCity.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nGOCity.widthAnchor.constraint(equalToConstant: 270).isActive = true
        nGOCity.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

    }
    
    private func setSavedDateLabelConstrains(){
        addSubview(savedDate)
        savedDate.translatesAutoresizingMaskIntoConstraints = false
        savedDate.topAnchor.constraint(equalTo: nGOName.bottomAnchor, constant: 20).isActive = true
        savedDate.leadingAnchor.constraint(equalTo: nGOCity.trailingAnchor, constant: 5).isActive = true
        savedDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        savedDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

    }

}
