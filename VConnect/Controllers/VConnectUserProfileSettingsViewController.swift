//
//  VConnectUserProfileSettingsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/30/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class VConnectUserProfileSettingsViewController: UIViewController {
    
   public var vConnectUserProfileSettingsView = VConnectUserProfileSettingsView()

    private var authServices = AppDelegate.authService
    
    var vConnectUser:VConnectUser!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(vConnectUserProfileSettingsView)
        view.backgroundColor = UIColor.init(hexString: "033860")
        vConnectUserProfileSettingsView.cancelButton.addTarget(self, action: #selector(canCelButtonPressed), for: .touchUpInside)
        
        vConnectUserProfileSettingsView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
    }
    
    @objc private func canCelButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonPressed(){
//        performSegue(withIdentifier: "EditBio", sender: self)
        
        print("Save button cliked")
    }
    
   

}
