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
    
    public lazy var contentView: UIView = {
        let contentView = UIView()
            contentView.backgroundColor = .green
        return contentView
    }()
    
    public lazy var logOutButton: UIButton = {
        let logOutButton = UIButton()
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        logOutButton.backgroundColor = .red
        logOutButton.layer.cornerRadius = 25
        return logOutButton
    }()


    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        bookMarkedNGOsTableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: "EditCell")
        bookMarkedNGOsTableView.register(BookMarkedTableViewCell.self, forCellReuseIdentifier: "BookMarkCell")
        bookMarkedNGOsTableView.register(EmailTableViewCell.self, forCellReuseIdentifier: "EmailCell")
        bookMarkedNGOsTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: "LogOutCell")
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
         //setContentViewContrains()
        setBookMarkedTableViewConstrains()
       
        //setLogOutContrains()
    }
    
    private func setTopViewConstrains(){
        addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    
   
    public func setBookMarkedTableViewConstrains(){
      addSubview(bookMarkedNGOsTableView)
        bookMarkedNGOsTableView.translatesAutoresizingMaskIntoConstraints = false
        bookMarkedNGOsTableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bookMarkedNGOsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bookMarkedNGOsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       bookMarkedNGOsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    



}
