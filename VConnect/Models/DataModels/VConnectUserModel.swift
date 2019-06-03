//
//  VConnectUserModel.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/20/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

struct VConnectUser: Codable {
    let firstName: String
    let lastName: String
    let emailAddress: String
    let location: String?
    let canReceiveNotification: Bool
    let profileImageURL: String?
    let userID: String
    
    init(firstName: String, lastName: String, emailAddress: String, location: String?, canReceiveNotification: Bool, profileImage: String?, userID: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.location = location
        self.canReceiveNotification = canReceiveNotification
        self.profileImageURL = profileImage
        self.userID = userID
    }
    
    init(dict: [String: Any]) {
        self.firstName =  dict[VConnectUserCollectionKeys.firstName] as? String ?? "VConnect user has no firstName"
        self.lastName = dict[VConnectUserCollectionKeys.lastName] as? String ?? "VConnect user has no lastName"
        self.emailAddress = dict[VConnectUserCollectionKeys.emailAddress] as? String ?? "VConnect user has no email address"
        self.location = dict[VConnectUserCollectionKeys.location] as? String ?? "VConnect user has no location"
        self.canReceiveNotification = dict[VConnectUserCollectionKeys.canReceiveNotification] as? Bool ?? false
        self.profileImageURL = dict[VConnectUserCollectionKeys.profileImageURL] as? String ?? "VConnect user has no profileImageURL"
        self.userID = dict[VConnectUserCollectionKeys.userID] as? String ?? "VConnect user has no userID"
    }
    
}


