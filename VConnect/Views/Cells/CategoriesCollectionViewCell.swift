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
        categoryName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        categoryName.numberOfLines = 0
        categoryName.textColor = .white
        return categoryName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
        categoryNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        categoryNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    
    
    
}
