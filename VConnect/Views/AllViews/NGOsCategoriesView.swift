//
//  NGOsView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsCategoriesView: UIView {

    public lazy var categoriesCollectionView: UICollectionView = {
        
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.scrollDirection = .vertical
//        cellLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        cellLayout.itemSize = CGSize.init(width: 400, height: 300)
        
        let categoriesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cellLayout)
        categoriesCollectionView.backgroundColor = .clear
    return categoriesCollectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        self.categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setCollectionViewConstrains()
        
    }
    
    
    
    private func setCollectionViewConstrains(){
        addSubview(categoriesCollectionView)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
