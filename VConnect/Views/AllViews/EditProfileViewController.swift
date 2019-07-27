//
//  EditProfileViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    //private var editProfileView = EditProfileView()
    
    private var vConnectUser: VConnectUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(editProfileView)
        view.backgroundColor = UIColor.init(hexString: "0072B1")
        setupView()

    }
    
    private func setupView(){
        
//        let editProfileView = EditProfileView()
//
//        editProfileView.translatesAutoresizingMaskIntoConstraints = false
//
//                editProfileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
//                editProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//                editProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//                editProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
//        editProfileView.backgroundColor = .red
//
        
        let editView = EditProfileView(frame: CGRect(x: 20, y: 50, width: 400, height: 400))
        editView.backgroundColor = .red
        view.addSubview(editView)
    }
    
    
    init(vconnectUser: VConnectUser) {
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
    
}
