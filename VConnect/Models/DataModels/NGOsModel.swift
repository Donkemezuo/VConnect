//
//  NGOsModel.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/20/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

struct NGO : Codable {
    
    let ngoName: String
    let ngoDescription: String
    let ngoWebsite: String?
    let ngoCategory: String
    let ngoAcrimony: String?
    let ngoPhoneNumber: String
    let ngoEmail: String
    let ngoStreetAddress: String
    let ngoCity: String
    let ngoState: String
    let ngoZipCode: String
    let contactPersonName: String
    let ngoImagesURL: String
    let ratingsValue: Double
    let reviews: String
    let mondayHours: String
    let tuesdayHours: String
    let wedsDayHours: String
    let thursdayHours: String
    let fridayHours: String
    let saturdayHours: String
    let sundayHours: String
    var fullAddress: String {
        
        let fullAddress = """
\(ngoStreetAddress)
\(ngoCity)
\(ngoState)
\(ngoZipCode)
"""
        return fullAddress
        
    }
    
    init(ngoName: String, ngoDescription: String, ngoWebsite: String, ngoCategory: String, ngoAcrimony: String, ngoPhoneNumber: String, ngoEmail: String, ngoStreetAddress: String, ngoCity: String, ngoState: String, ngoZipCode: String, contactPersonName: String, ngoImagesURL: String, ratingsValue: Double, reviews: String, mondayHours: String, tuesdayHours: String, wedsDayHours: String, thursdayHours: String, fridayHours: String, saturdayHours: String, sundayHours: String){
        self.ngoName = ngoName
        self.ngoDescription = ngoDescription
        self.ngoWebsite = ngoWebsite
        self.ngoCategory = ngoCategory
        self.ngoAcrimony = ngoAcrimony
        self.ngoPhoneNumber = ngoPhoneNumber
        self.ngoEmail = ngoEmail
        self.ngoStreetAddress = ngoStreetAddress
        self.ngoCity = ngoCity
        self.ngoState = ngoState
        self.ngoZipCode = ngoZipCode
        self.contactPersonName = contactPersonName
        self.ngoImagesURL = ngoImagesURL
        self.ratingsValue = ratingsValue
        self.reviews = reviews
        self.mondayHours = mondayHours
        self.tuesdayHours = tuesdayHours
        self.wedsDayHours = wedsDayHours
        self.thursdayHours = thursdayHours
        self.fridayHours = fridayHours
        self.saturdayHours = saturdayHours
        self.sundayHours = sundayHours
    }
    
    init(dict: [String: Any]) {
        
        self.ngoName = dict[NGOsCollectionKeys.ngoName] as? String ?? "NGO does not have a name"
        self.ngoDescription = dict[NGOsCollectionKeys.ngoDescription] as? String ?? "NGO does not have a description"
        self.ngoWebsite = dict[NGOsCollectionKeys.ngoWebsite] as? String ?? "NGO does not have a registered website"
        self.ngoCategory = dict[NGOsCollectionKeys.ngoCategory] as? String ?? "NGO does not specify category"
        self.ngoAcrimony = dict[NGOsCollectionKeys.ngoAcrimony] as? String ?? "NGO does not have an acrimony"
        self.ngoPhoneNumber = dict[NGOsCollectionKeys.ngoPhoneNumber] as? String ?? "NGO has no registered phone number"
        self.ngoEmail = dict[NGOsCollectionKeys.ngoEmail] as? String ?? "NGO has no registered email address"
        self.ngoStreetAddress = dict[NGOsCollectionKeys.ngoStreetAddress] as? String ?? "NGO does not have a registered street address"
        self.ngoCity = dict[NGOsCollectionKeys.ngoCity] as? String ?? "NGO does not have a registered city"
        self.ngoState = dict[NGOsCollectionKeys.ngoState] as? String ?? "NGO does not have a registered state"
        self.ngoZipCode = dict[NGOsCollectionKeys.ngoZipCode] as? String ?? "NGO does not have a registered zipCode"
        self.contactPersonName = dict[NGOsCollectionKeys.contactPersonName] as? String ?? "NGO does not have a registered contact person"
        self.ngoImagesURL = dict[NGOsCollectionKeys.ngoImagesURL] as? String ?? "NGO does not have any images uploaded"
        self.ratingsValue = dict[NGOsCollectionKeys.ratingsValue] as? Double ?? 0.0
        self.reviews = dict[NGOsCollectionKeys.reviews] as? String ?? "NGO does not have any reviews yet"
        self.mondayHours = dict[NGOsCollectionKeys.mondayHours] as? String ?? "NGO does not have open hours on monday"
        self.tuesdayHours = dict[NGOsCollectionKeys.tuesdayHours] as? String ?? "NGO does not have open hours on tuesday"
        self.wedsDayHours = dict[NGOsCollectionKeys.wedsDayHours] as? String ?? "NGO does not have open hours on wednesday"
        self.thursdayHours = dict[NGOsCollectionKeys.thursdayHours] as? String ?? "NGO does not have open hours on thursday"
        self.fridayHours = dict[NGOsCollectionKeys.fridayHours] as? String ?? "NGO does not have open hours on friday"
        self.saturdayHours = dict[NGOsCollectionKeys.saturdayHours] as? String ?? "NGO does not have open hours on saturday"
        self.sundayHours = dict[NGOsCollectionKeys.sundayHours] as? String ?? "NGO does not have open hours on sundays"
    
    
    }
    
}
