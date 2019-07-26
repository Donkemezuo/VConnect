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
    
    static func createSpecialist(with connectSpecialist: VConnectSpecialist, completionHandler: @escaping(Error?) -> Void) {
        firestoreDataBase.collection(VConnectSpecialistCollectionKeys.vConnectSpecialistCollectionKeys).document(connectSpecialist.specialistID).setData([VConnectSpecialistCollectionKeys.specialistID: connectSpecialist.specialistID,
                                                                                                                                                          VConnectSpecialistCollectionKeys.areaOfSpecialty: connectSpecialist.areaOfSpecialty,
                                                                                                                                                          VConnectSpecialistCollectionKeys.biography: connectSpecialist.biography,
                                                                                                                                                          VConnectSpecialistCollectionKeys.firstName: connectSpecialist.firstName,
                                                                                                                                                          VConnectSpecialistCollectionKeys.joinedDate: connectSpecialist.joinedDate,
                                                                                                                                                          VConnectSpecialistCollectionKeys.lastName: connectSpecialist.lastName,
                                                                                                                                                          VConnectSpecialistCollectionKeys.location: connectSpecialist.location,
                                                                
                                                                                                                                                          VConnectSpecialistCollectionKeys.ratingsValue: connectSpecialist.ratingsValue,
                                                                                    
                                                                                                                                                          VConnectSpecialistCollectionKeys.specialistID: connectSpecialist.specialistID,
                                                                                                                                                          VConnectSpecialistCollectionKeys.specialistProfileImageURL: connectSpecialist.specialistProfileImageURL ?? "",
                                                                                                                                                          VConnectSpecialistCollectionKeys.yearsOfExperience: connectSpecialist.yearsOfExperience, VConnectSpecialistCollectionKeys.profession: connectSpecialist.profession
        ]) { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
        
        
        
    }
    
    static public func fetchVConnectBookMarkedNGOs(_ vconnectUserID: String, completionHandler: @escaping(Error?, [BookMark]?) -> Void) {
        var allBookMarks = [BookMark]()
        DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(vconnectUserID).collection(VConnectUserCollectionKeys.bookMarkedNGOs).addSnapshotListener(includeMetadataChanges: true) { (snapShot, error) in
            if let error = error {
                completionHandler(error, nil)
            } else if let snapShot = snapShot {
                allBookMarks.removeAll()
                for document in snapShot.documents {
                    let bookMark = BookMark.init(dict: document.data())
                    allBookMarks.append(bookMark)
                }
                completionHandler(nil, allBookMarks)
            }
        }
        
    }
    
    static public func createBookMark(onVConnectUserID vConnectUserID: String, bookMarkNGO: BookMark, completionHandler: @escaping(Error?) -> Void) {
        DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(vConnectUserID).collection(VConnectUserCollectionKeys.bookMarkedNGOs).addDocument(data: [NGOsCollectionKeys.ngOID: bookMarkNGO.ngoID, NGOsCollectionKeys.visitedDate: Date.customizedDateFormat()]) { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
        
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
    
    static public func createReview(on nGOID: String,reviewerID: String,with review: String, withA ratingValue: Double, completionHandler:@escaping(Error?) -> Void) {
        
        DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(nGOID).collection(NGOReviewsCollectionKey.nGOReviews).addDocument(data: [NGOReviewsCollectionKey.reviewerID: reviewerID, NGOReviewsCollectionKey.date: Date.reviewDateFormatter(), NGOReviewsCollectionKey.review: review, NGOReviewsCollectionKey.ratingValue: ratingValue]) { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
   
    
    
    static public func fetchAllNGOReviews(with ngoID: String, completionHandler: @escaping(Error?, [NGOReviews]?) -> Void) {
        
        var allReviews = [NGOReviews]()
  DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).document(ngoID).collection(NGOReviewsCollectionKey.nGOReviews).addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, error) in
            if let error = error {
                completionHandler(error, nil)
            }else if let querySnapShot = querySnapshot {
                allReviews.removeAll()
                for document in querySnapShot.documents {
                    let ngoReview = NGOReviews.init(dict: document.data())
                    allReviews.append(ngoReview)
       
                }
                
      completionHandler(nil, allReviews)
            }
        }
    }
    
    

    
  
    
    static public func fetchVConnectUserr(with vConnectID: String, completionHandler: @escaping(Error?, VConnectUser?) -> Void) {
        DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).whereField(VConnectUserCollectionKeys.userID, isEqualTo: vConnectID).addSnapshotListener(includeMetadataChanges: true) { (snapShot, error) in
            if let error = error {
                completionHandler(error, nil)
            } else if let snapshotDoc = snapShot?.documents.first {
                let vConnectUser = VConnectUser.init(dict: snapshotDoc.data())
                completionHandler(nil, vConnectUser)
            }
        }
    }
    
    static public func saveProfileImage(with imageData: Data, with imageName: String, with completionHandler: @escaping (Error?, URL?) -> Void){
        
        let metaData = StorageMetadata()
        let imageRef = storageService.child(VConnectUserCollectionKeys.profileImageURL + "/\(imageName)" + ".jpg")
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
            print("Failure")
            //
        }
        
        uploadTask.observe(.pause) { (snapShot) in
             print("Pause")
            //
        }
        
        uploadTask.observe(.progress) { (snapShot) in
             print("progress")
            //
        }
        
        uploadTask.observe(.resume) { (snapShot) in
            //
             print("resume")
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
   
    
    static public func deleteBookMark(bookMarkedNGO ngo: NGO, vConnectUserID: String, completionHandler: @escaping (Error?) -> Void) {
        
        DataBaseService.firestoreDataBase.collection(VConnectUserCollectionKeys.vConnectUsersCollectionKey).document(vConnectUserID).collection(VConnectUserCollectionKeys.bookMarkedNGOs).document()
        
    }

}
