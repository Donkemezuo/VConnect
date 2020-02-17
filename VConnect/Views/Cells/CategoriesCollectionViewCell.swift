//
//  CategoriesCollectionViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    public lazy var categoryNameLabel: UILabel = {
        let categoryName = UILabel()
        categoryName.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        categoryName.numberOfLines = 0
        categoryName.textColor = .white 
        return categoryName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = 5
        commonInt()
    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInt()
    }
    private func commonInt(){
        setNameLabelConstrains()
    }
    
    private func setNameLabelConstrains(){
        addSubview(categoryNameLabel)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //categoryNameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    
    
    
}
