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
    
    static public func createVConnectUserNGOBookMark(vConnectUserID: String, bookMarkedNGOs: NGO, completionHandler: @escaping(AppError?) -> Void) {
        firestoreDataBase.collection(BookMarkedNGOCollectionKey.bookMarkedNgoCollectionKey).document(vConnectUserID).setData([BookMarkedNGOCollectionKey.contactPersonName: bookMarkedNGOs.contactPersonName, BookMarkedNGOCollectionKey.fridayHours: bookMarkedNGOs.fridayHours, BookMarkedNGOCollectionKey.mondayHours: bookMarkedNGOs.mondayHours, BookMarkedNGOCollectionKey.ngoAcrimony : bookMarkedNGOs.ngoAcrimony ?? " ", BookMarkedNGOCollectionKey.ngoCategory: bookMarkedNGOs.ngoCategory, BookMarkedNGOCollectionKey.ngoCity : bookMarkedNGOs.ngoCity, BookMarkedNGOCollectionKey.ngoDescription: bookMarkedNGOs.ngoDescription, BookMarkedNGOCollectionKey.ngoEmail: bookMarkedNGOs.ngoEmail, BookMarkedNGOCollectionKey.ngoImagesURL: bookMarkedNGOs.ngoImagesURL, BookMarkedNGOCollectionKey.ngoName: bookMarkedNGOs.ngoName, BookMarkedNGOCollectionKey.ngoPhoneNumber: bookMarkedNGOs.ngoPhoneNumber, BookMarkedNGOCollectionKey.ngoState: bookMarkedNGOs.ngoState, BookMarkedNGOCollectionKey.ngoStreetAddress: bookMarkedNGOs.ngoStreetAddress, BookMarkedNGOCollectionKey.ngoWebsite: bookMarkedNGOs.ngoWebsite ?? " ", BookMarkedNGOCollectionKey.ngoZipCode: bookMarkedNGOs.ngoZipCode, BookMarkedNGOCollectionKey.ratingsValue: bookMarkedNGOs.ratingsValue, BookMarkedNGOCollectionKey.reviews: bookMarkedNGOs.reviews, BookMarkedNGOCollectionKey.saturdayHours: bookMarkedNGOs.saturdayHours, BookMarkedNGOCollectionKey.sundayHours: bookMarkedNGOs.sundayHours, BookMarkedNGOCollectionKey.thursdayHours: bookMarkedNGOs.thursdayHours, BookMarkedNGOCollectionKey.tuesdayHours: bookMarkedNGOs.tuesdayHours, BookMarkedNGOCollectionKey.wedsDayHours: bookMarkedNGOs.wedsDayHours, BookMarkedNGOCollectionKey.vConnectUserID: vConnectUserID, BookMarkedNGOCollectionKey.bookMarkedDate: Date.customizedDateFormat()], completion: { (error) in
            if let error = error {
                completionHandler((error as! AppError))
            } else {
                completionHandler(nil)
            }
        })
        
    }
    
    static public func createNGO(with ngo: NGO, completionHandler: @escaping(Error?) -> Void) {
        firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(ngo.ngOID).setData([NGOsCollectionKeys.contactPersonName: ngo.contactPersonName, NGOsCollectionKeys.fridayHours: ngo.fridayHours, NGOsCollectionKeys.mondayHours: ngo.mondayHours, NGOsCollectionKeys.ngoAcrimony: ngo.ngoAcrimony ?? "", NGOsCollectionKeys.ngoCategory: ngo.ngoCategory, NGOsCollectionKeys.ngoCity: ngo.ngoCity, NGOsCollectionKeys.ngoDescription: ngo.ngoDescription, NGOsCollectionKeys.ngoEmail: ngo.ngoEmail, NGOsCollectionKeys.ngOID: ngo.ngOID, NGOsCollectionKeys.ngoImagesURL: ngo.ngoImagesURL, NGOsCollectionKeys.ngoName: ngo.ngoName, NGOsCollectionKeys.ngoPhoneNumber: ngo.ngoPhoneNumber, NGOsCollectionKeys.ngoState: ngo.ngoState, NGOsCollectionKeys.ngoStreetAddress: ngo.ngoStreetAddress, NGOsCollectionKeys.ngoWebsite: ngo.ngoWebsite ?? "", NGOsCollectionKeys.ngoZipCode: ngo.ngoZipCode, NGOsCollectionKeys.ratingsValue: ngo.ratingsValue, NGOsCollectionKeys.reviews: ngo.reviews, NGOsCollectionKeys.saturdayHours: ngo.saturdayHours, NGOsCollectionKeys.sundayHours: ngo.sundayHours, NGOsCollectionKeys.thursdayHours: ngo.thursdayHours, NGOsCollectionKeys.tuesdayHours: ngo.tuesdayHours, NGOsCollectionKeys.visitedDate: ngo.visitedDate, NGOsCollectionKeys.wedsDayHours: ngo.wedsDayHours]) { (error) in
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
    
    static public func fetchBookMarkedNGOs(vConnectUserID: String, completionHandler: @escaping(Error?, [NGO]?) -> Void) {
        
        DataBaseService.firestoreDataBase.collection(BookMarkedNGOCollectionKey.bookMarkedNgoCollectionKey).whereField(BookMarkedNGOCollectionKey.vConnectUserID, isEqualTo: vConnectUserID).getDocuments { (snapShot, error) in
            if let error =  error {
                completionHandler(error, nil)
            } else if let snapShot = snapShot {
                var allBookMarkedNGOs = [NGO]()
                
                for nGOs in snapShot.documents {
                        let bookMarkedNGOs = NGO.init(dict: nGOs.data())
                    allBookMarkedNGOs.append(bookMarkedNGOs)
                }
                

                completionHandler(nil, allBookMarkedNGOs)
                
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
                
                print("We encountered this error: \(error.localizedDescription)")
             
            } else if let metaData = metaData {
                
                print(metaData)
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
