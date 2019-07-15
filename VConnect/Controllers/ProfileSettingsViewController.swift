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
    case settings
    case logOut
}



class ProfileSettingsViewController: UITableViewController {
    
    var didSelectCell: ((SelectedCellType) -> Void)?

     var vConnectUser: VConnectUser?
    
    private var authService = AppDelegate.authService
    
    @IBOutlet weak var profileCell: UserInfoTableViewCell!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "2E294E")?.withAlphaComponent(0.85)
        setUserInfo(with: profileCell)
        view.layer.cornerRadius = 10
        view.isOpaque = false
        
   
        
    }
    
    

    
    private func setUserInfo(with userInfoCell: UserInfoTableViewCell){
        guard let firstName = vConnectUser?.firstName, let lastName = vConnectUser?.lastName, let photoUrl = vConnectUser?.profileImageURL,
    !photoUrl.isEmpty else {return }
        
        let fullName = firstName + " " + lastName
        userInfoCell.userNameLabel?.text = fullName
        userInfoCell.userImageView?.kf.setImage(with: URL(string: photoUrl), placeholder:#imageLiteral(resourceName: "VCConectLogo.png") )
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    private func segueToProfileSettingVC(){
        
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "VConnectUserProfileSettingsViewController") as? VConnectUserProfileSettingsViewController else {return}
        destination.vConnectUser = vConnectUser
        present(destination, animated: true, completion: nil)
    }
    
    private func segueToMapView(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let googleMapVC = storyBoard.instantiateViewController(withIdentifier: "GoogleMapViewController") as? GoogleMapViewController else {return }
        googleMapVC.modalTransitionStyle = .crossDissolve
        googleMapVC.modalPresentationStyle = .overCurrentContext
        present(googleMapVC, animated: true)
    }
    
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = SelectedCellType(rawValue: indexPath.row - 1) else {return}
        
        switch selectedCell {
        case .profileSetting:
         segueToProfileSettingVC()
            //tableView.separatorStyle = .none
        case .settings:
            segueToMapView()
            //navigationController?.pushViewController(GoogleMapViewController(), animated: true)
            //present(GoogleMapViewController(), animated: true)
        case .logOut:
            authService.signOutVConnectUser()
             //tableView.separatorStyle = .none

        }
        
        dismiss(animated: true) {[weak self] in
            self?.didSelectCell?(selectedCell)
        }
        
    }
    
    
    
    
    
    
    
    

}


