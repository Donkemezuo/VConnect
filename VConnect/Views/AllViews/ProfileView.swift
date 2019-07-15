//
//  ProfileView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/12/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    public lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.init(hexString: "0072B1")
        return topView
    }()
    
    public lazy var bookMarkedNGOsTableView: UITableView = {
        let bookMarkedNGOsTableView = UITableView()
        bookMarkedNGOsTableView.backgroundColor =  UIColor.init(hexString: "0072B1")
        return bookMarkedNGOsTableView
    }()


    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        bookMarkedNGOsTableView.register(BookMarkedTableViewCell.self, forCellReuseIdentifier: "BookMarkedTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setConstrains()
    }
    
    private func setConstrains(){
        setTopViewConstrains()
        setBookMarkedTableViewConstrains()
    }
    
    private func setTopViewConstrains(){
        addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
   
    private func setBookMarkedTableViewConstrains(){
        addSubview(bookMarkedNGOsTableView)
        bookMarkedNGOsTableView.translatesAutoresizingMaskIntoConstraints = false
        bookMarkedNGOsTableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bookMarkedNGOsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bookMarkedNGOsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bookMarkedNGOsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }


}
