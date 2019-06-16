//
//  ProfileSettingsViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

enum SelectedCellType: Int {
    case profileSetting
    case becomeSpecialist
    case registerNGO
    case logOut
}



class ProfileSettingsViewController: UITableViewController {
    
    var didSelectCell: ((SelectedCellType) -> Void)?

    
    var vConnectUser: VConnectUser?
    
    @IBOutlet weak var profileCell: UserInfoTableViewCell!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "033860")
        setUserInfo(with: profileCell)
    }
    
    private func setUserInfo(with userInfoCell: UserInfoTableViewCell){
        guard let firstName = vConnectUser?.firstName, let lastName = vConnectUser?.lastName else {return }
        
        let fullName = firstName + " " + lastName
        userInfoCell.userNameLabel?.text = fullName
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = SelectedCellType(rawValue: indexPath.row) else {return}
        dismiss(animated: true) {[weak self] in
            self?.didSelectCell?(selectedCell)
        }
        
        
    }
    
    
    
    
    
    

}


