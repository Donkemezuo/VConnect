//
//  NGOsTableView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsTableView: UIView {
    
    public lazy var nGOsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.init(hexString: "033860")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        self.nGOsTableView.register(NGOsTableViewCell.self, forCellReuseIdentifier: "NGOsTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
    
        setTableViewConstrains()
    }
    
    private func setTableViewConstrains(){
        addSubview(nGOsTableView)
        nGOsTableView.translatesAutoresizingMaskIntoConstraints = false
        nGOsTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nGOsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nGOsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nGOsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
