//
//  VConnectSpecialistModel.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/21/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

struct VConnectSpecialist: Codable {
    
    let firstName: String
    let lastName: String
    let biography: String
    //let age: Int
    let location: String
    let areaOfSpecialty: String
    let yearsOfExperience: Int
    let ratingsValue: Double
    //let reviews: String
    let specialistID: String
    let specialistProfileImageURL: String?
   // let portfolioImagesURL: String
    let joinedDate: String
    let coverImageURL: String?
    let profession: String
    init(firstName: String, lastName: String, biography: String, location: String, areaOfSpecialty: String, yearsOfExperience: Int, ratingsValue: Double, specialistID: String, specialistProfileImageURL: String, joinedDate: String, coverImageURL: String,profession: String){
        
        self.firstName = firstName
        self.lastName = lastName
        self.biography = biography
        //self.age = age
        self.location = location
        self.areaOfSpecialty = areaOfSpecialty
        self.yearsOfExperience = yearsOfExperience
        self.ratingsValue = ratingsValue
       // self.reviews = reviews
        self.specialistID = specialistID
        self.specialistProfileImageURL = specialistProfileImageURL
        //self.portfolioImagesURL = portfolioImagesURL
        self.joinedDate = joinedDate
        self.coverImageURL = coverImageURL
        self.profession = profession
    }
    
    init(dict:[String: Any]){
        self.firstName = dict[VConnectSpecialistCollectionKeys.firstName] as? String ?? "Specialist has no first name"
        self.lastName = dict[VConnectSpecialistCollectionKeys.lastName] as? String ?? "Specialist has no last name"
        self.biography = dict[VConnectSpecialistCollectionKeys.biography] as? String ?? "Specialist have no bio set"
       // self.age = dict[VConnectSpecialistCollectionKeys.age] as? Int ?? 30
        self.location = dict[VConnectSpecialistCollectionKeys.location] as? String ?? "Specialist have no location set"
        self.areaOfSpecialty = dict[VConnectSpecialistCollectionKeys.areaOfSpecialty] as? String ?? "Specialist has no area of specialty set"
        self.yearsOfExperience = dict[VConnectSpecialistCollectionKeys.yearsOfExperience] as? Int ?? 1
        self.ratingsValue = dict[VConnectSpecialistCollectionKeys.ratingsValue] as? Double ?? 3.0
        self.specialistID = dict[VConnectSpecialistCollectionKeys.specialistID] as? String ?? "Specialist has no ID"
        self.specialistProfileImageURL = dict[VConnectSpecialistCollectionKeys.specialistProfileImageURL] as? String ?? "No Specialty profile image URL"
        self.joinedDate = dict[VConnectSpecialistCollectionKeys.joinedDate] as? String ?? "No joined date"
        self.coverImageURL = dict[VConnectSpecialistCollectionKeys.coverImageURL] as? String ?? "No cover image url"
        self.profession = dict[VConnectSpecialistCollectionKeys.profession] as? String ?? "No specified profession"
        
    }
    
    
    
}
