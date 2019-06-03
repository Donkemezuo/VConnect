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
    let age: Int
    let location: String
    let areaOfSpecialty: String
    let yearsOfExperience: Int
    let ratingsValue: Double
    let reviews: String
    let specialistID: String
    let specialistProfileImageURL: String?
    let portfolioImagesURL: String
    let joinedDate: String
    
    init(firstName: String, lastName: String, biography: String, age: Int, location: String, areaOfSpecialty: String, yearsOfExperience: Int, ratingsValue: Double, reviews: String, specialistID: String, specialistProfileImageURL: String, portfolioImagesURL: String, joinedDate: String){
        
        self.firstName = firstName
        self.lastName = lastName
        self.biography = biography
        self.age = age
        self.location = location
        self.areaOfSpecialty = areaOfSpecialty
        self.yearsOfExperience = yearsOfExperience
        self.ratingsValue = ratingsValue
        self.reviews = reviews
        self.specialistID = specialistID
        self.specialistProfileImageURL = specialistProfileImageURL
        self.portfolioImagesURL = portfolioImagesURL
        self.joinedDate = joinedDate
    }
    
}
