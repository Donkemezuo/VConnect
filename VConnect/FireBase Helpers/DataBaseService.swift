//
//  DataBaseService.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

final class DataBaseService {
    private init() {}
    
    public static var firestoreDataBase: Firestore = {
        let dataBase = Firestore.firestore()
        let settings = dataBase.settings
        dataBase.settings = settings
        return dataBase
    }()
    
    public static var storageService: StorageReference = {
        let imageRef = Storage.storage().reference()
        return imageRef
        
    }()
    
    
    public static var generateDocumentID: String {
        return firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document().documentID
    }
    
    static public func createVConnectUser(vConnectUser: VConnectUser, completionHandler: @escaping(Error?) -> Void){
        firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(vConnectUser.userID).setData([VConnectUserCollectionKeys.userID : vConnectUser.userID,
                                                                                                                                   VConnectUserCollectionKeys.firstName: vConnectUser.firstName,
                                                                                                                                   VConnectUserCollectionKeys.lastName : vConnectUser.lastName,
                                                                                                                                   VConnectUserCollectionKeys.emailAddress : vConnectUser.emailAddress,
                                                                                                                                   VConnectUserCollectionKeys.location : vConnectUser.location ?? "",
                                                                                                                                   VConnectUserCollectionKeys.profileImageURL : vConnectUser.profileImageURL ?? ""
        ]) {(error) in
            
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    
    
    static public func fetchVConnectUser(vConnectUserID: String, completionHandler: @escaping(Error?, VConnectUser?) -> Void) {
        DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).whereField(VConnectUserCollectionKeys.userID, isEqualTo: vConnectUserID).getDocuments { (querySnapShot, error) in
            if let error = error {
                completionHandler(error, nil)
            } else if let querySnapShot = querySnapShot?.documents.first {
                let vConnectUser = VConnectUser(dict: querySnapShot.data())
                completionHandler(nil, vConnectUser)
            }
        }
    }
    
    
    static public func saveProfileImage(with imageData: Data, with imageName: String, with completionHandler: @escaping (Error?, URL?) -> Void){
        
        let metaData = StorageMetadata()
        let imageRef = storageService.child(VConnectUserCollectionKeys.profileImageURL + "/\(imageName)")
        metaData.contentType = "image/jpg"
        let uploadTask = imageRef
            .putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
             
            } else if let _ = metaData {
                
            }
        }
        uploadTask.observe(.failure) { (snapShot) in
            //
        }
        
        uploadTask.observe(.pause) { (snapShot) in
            //
        }
        
        uploadTask.observe(.progress) { (snapShot) in
            //
        }
        
        uploadTask.observe(.resume) { (snapShot) in
            //
        }
        
        uploadTask.observe(.success) { (snapShot) in
            //
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    completionHandler(error, nil)
                } else if let imageUrl = url {
                    completionHandler(nil, imageUrl)
                }
            })
        }
    }
    
}
