//
//  NGOPhotosView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/31/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOPhotosView: UIView {

    public lazy var nGOPhotosCollectionView: UICollectionView = {
        
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.scrollDirection = .vertical
        cellLayout.itemSize = CGSize.init(width: 180, height: 140)
        let nGOPhotosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cellLayout)
        nGOPhotosCollectionView.backgroundColor = .clear
        nGOPhotosCollectionView.isScrollEnabled = true 
        return nGOPhotosCollectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        self.nGOPhotosCollectionView.register(NGOPhotosCollectionViewCell.self, forCellWithReuseIdentifier: "NGOPhotosCollectionViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setNGOPhotosCollectionViewConstrains()
    }

    private func setNGOPhotosCollectionViewConstrains(){
        addSubview(nGOPhotosCollectionView)
        nGOPhotosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nGOPhotosCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nGOPhotosCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nGOPhotosCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nGOPhotosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
