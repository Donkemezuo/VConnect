//
//  BookMarksTableViewCell.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/23/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class BookMarksTableViewCell: UITableViewCell {
    
    public lazy var bookMarksLabel: UILabel = {
        let bookMarksLabel = UILabel()
        bookMarksLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        bookMarksLabel.textColor = .white
        bookMarksLabel.text = "BookMarked NGOs"
        bookMarksLabel.numberOfLines = 0
        return bookMarksLabel
    }()
    
    public lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
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
        setConstrains()
        
    }
    
    private func  setConstrains(){
        setBookMarksLabelConstrains()
        setContainerViewConstrains()
        setTableViewContrains()
        
    }
    
    private func setBookMarksLabelConstrains(){
        addSubview(bookMarksLabel)
        bookMarksLabel.translatesAutoresizingMaskIntoConstraints = false
        bookMarksLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bookMarksLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bookMarksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bookMarksLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setContainerViewConstrains(){
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: bookMarksLabel.bottomAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    private func setTableViewContrains(){
        containerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }

}
