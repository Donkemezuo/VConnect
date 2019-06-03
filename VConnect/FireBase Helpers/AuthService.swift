//
//  AuthService.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol AuthServiceCreateNewVConnectUserAccountDelegate: AnyObject {
    func didReceiveErrorCreatingVConnectUserAccount(_ authService: AuthService, error: Error)
    
    func didCreateNewVConnectUserAccount(_ authService: AuthService, vconnectUser: VConnectUser)

}

protocol AuthServiceExistingVConnectAccountDelegate: AnyObject {
    func didReceiveErrorSigningToVConnectExistingAccount(_ authService: AuthService, error: Error )
    
    func didSignInToExistingVConnectUserAccount(_ authService: AuthService, user: User)
}

protocol AuthServiceSignOutVConnectUserDelegate: AnyObject {
    
    func didSignOutWithError(_ authservice: AuthService, error: Error)
    func didSignOut(_ authservice: AuthService)
}

final class AuthService {
    weak var authServiceCreateNewVConnectUserAccountDelegate: AuthServiceCreateNewVConnectUserAccountDelegate?
    weak var authServiceExistingVConnectUserAccountDelegate: AuthServiceExistingVConnectAccountDelegate?
    weak var authServiceSignOutVConnectUser: AuthServiceSignOutVConnectUserDelegate?
    
    public func createNewVConnectUser(firstName: String, lastName: String, email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.authServiceCreateNewVConnectUserAccountDelegate?.didReceiveErrorCreatingVConnectUserAccount(self, error: error)
                return
            } else {
                if let authDataResult = authDataResult {
                    let request = authDataResult.user.createProfileChangeRequest()
                    request.displayName = firstName
                    request.commitChanges(completion: { (error) in
                        if let error = error {
                            self.authServiceCreateNewVConnectUserAccountDelegate?.didReceiveErrorCreatingVConnectUserAccount(self, error: error)
                            return
                        }
                    })
                    
                    guard let vConnectUserID = Auth.auth().currentUser?.uid else {return}
                    
                    let vConnectUser = VConnectUser.init(firstName: firstName, lastName: lastName, emailAddress: email, location: nil, canReceiveNotification: false, profileImage: nil, userID: vConnectUserID)
                    DataBaseService.createVConnectUser(vConnectUser: vConnectUser, completionHandler: { (error) in
                        if let error = error {
                            self.authServiceCreateNewVConnectUserAccountDelegate?.didReceiveErrorCreatingVConnectUserAccount(self, error: error)
                        } else {
                            self.authServiceCreateNewVConnectUserAccountDelegate?.didCreateNewVConnectUserAccount(self, vconnectUser: vConnectUser)
                        }
                    })
                    
                }
            }
        }
        
    }
    
    public func signInExistingVConnectUserAccount(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.authServiceExistingVConnectUserAccountDelegate?.didReceiveErrorSigningToVConnectExistingAccount(self, error: error)
            } else {
                if let authDataResult = authDataResult {
                    self.authServiceExistingVConnectUserAccountDelegate?.didSignInToExistingVConnectUserAccount(self, user: authDataResult.user)
                }
            }
        }
    }
    
    public func getCurrentVConnectUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func signOutVConnectUser(){
        
        do {
            try Auth.auth().signOut()
            authServiceSignOutVConnectUser?.didSignOut(self)
        } catch {
            authServiceSignOutVConnectUser?.didSignOutWithError(self, error: error)
        }
    }
    
}


