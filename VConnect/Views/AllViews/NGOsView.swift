//
//  NGOsView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/25/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsView: UIView {
    
    public lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter City, State or Postal Code"
        searchBar.autocorrectionType = UITextAutocorrectionType.yes
        searchBar.scopeBarButtonTitleTextAttributes(for: .normal)
        
        return searchBar
    }()
    
    public lazy var toggleView: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "List", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Map", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    public lazy var resourcesView: UIView = {
        let resourcesView = UIView()
        return resourcesView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        setConstrains()
        
    }
    
    private func setConstrains(){
        searchBarConstrains()
        setSegmentedControlConstrains()
        setupViewsConstrains()
    }
    
    private func searchBarConstrains(){
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 2).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
         searchBar.widthAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    private func setSegmentedControlConstrains(){
        addSubview(toggleView)
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        toggleView.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 2).isActive = true
        toggleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -2).isActive = true
        toggleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupViewsConstrains(){
        addSubview(resourcesView)
        resourcesView.translatesAutoresizingMaskIntoConstraints = false
        resourcesView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 3).isActive = true
        resourcesView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        resourcesView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        resourcesView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    

}
