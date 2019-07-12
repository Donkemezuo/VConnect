//
//  NGOsTableView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsTableView: UIView {
    
    public lazy var containView: UIView = {
        let containView = UIView()
     containView.backgroundColor = UIColor.init(hexString: "2E294E")
        // containView.backgroundColor = UIColor.init(hexString: "3D2F54")
        //containView.backgroundColor = UIColor.init(hexString: "033860")
        return containView
        
    }()
    
    public lazy var settingButton: UIButton = {
        
        let settingButton = UIButton()
        
        settingButton.setImage(#imageLiteral(resourceName: "icons8-menu.png").withRenderingMode(.alwaysTemplate),for: .normal)
        settingButton.tintColor = UIColor.white
        //settingButton.setTitleColor(.white, for: .normal)
        
        return settingButton
        
    }()
    
    public lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        
        textLabel.text = "VConnect"
        textLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        
        return textLabel
    }()
    
    
    public lazy var categoriesCollectionView: UICollectionView = {
        
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.scrollDirection = .horizontal
        cellLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
         cellLayout.itemSize = CGSize.init(width: 200, height: 30)
        
        let categoriesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cellLayout)
        categoriesCollectionView.backgroundColor = UIColor.init(hexString: "033860")
        return categoriesCollectionView
    }()
    
    
    
    public lazy var nGOsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear 
        //tableView.backgroundColor = UIColor.init(hexString: "033860")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        self.nGOsTableView.register(NGOsTableViewCell.self, forCellReuseIdentifier: "NGOsTableViewCell")
        nGOsTableView.separatorStyle = .none
        
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
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
        setCollectionViewConstrains()
        setTableViewConstrains()
        
    }
    
    private func setContainerViewConstrains(){
        addSubview(containView)
        containView.translatesAutoresizingMaskIntoConstraints = false
        containView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        containView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        containView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    
    private func setSettingsButtonConstrains(){
        containView.addSubview(settingButton)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        //settingButton.topAnchor.constraint(equalTo: containView.topAnchor, constant: 30).isActive = true
        settingButton.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 10).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingButton.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setTxtLabelConstrains(){
        containView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
       // textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 0).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: containView.trailingAnchor).isActive = true
       // textLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
         textLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setCollectionViewConstrains(){
        addSubview(categoriesCollectionView)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.topAnchor.constraint(equalTo: containView.bottomAnchor, constant: 0).isActive = true
        categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categoriesCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    private func setTableViewConstrains(){
        addSubview(nGOsTableView)
        nGOsTableView.translatesAutoresizingMaskIntoConstraints = false
        nGOsTableView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor).isActive = true
        nGOsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nGOsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nGOsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    


}
