//
//  BookMarkedNGO.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/11/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

//struct bookMarkedNGO {
//        let ngoName: String
//        let ngoDescription: String
//        let ngoWebsite: String?
//        let ngoCategory: String
//        let ngoAcrimony: String?
//        let ngoPhoneNumber: String
//        let ngoEmail: String
//        let ngoStreetAddress: String
//        let ngoCity: String
//        let ngoState: String
//        let ngoZipCode: String
//        let contactPersonName: String
//        let ngoImagesURL: String
//        let ratingsValue: Double
//        let reviews: String
//        let mondayHours: String
//        let tuesdayHours: String
//        let wedsDayHours: String
//        let thursdayHours: String
//        let fridayHours: String
//        let saturdayHours: String
//        let sundayHours: String
//        let visitedDate: String
//        var fullAddress: String {
//
//            let fullAddress = """
//
//            \(ngoStreetAddress)
//
//            \(ngoCity)
//
//            \(ngoState)
//
//            \(ngoZipCode)
//            """
//            return fullAddress
//
//        }
//
//        init(ngoName: String, ngoDescription: String, ngoWebsite: String, ngoCategory: String, ngoAcrimony: String, ngoPhoneNumber: String, ngoEmail: String, ngoStreetAddress: String, ngoCity: String, ngoState: String, ngoZipCode: String, contactPersonName: String, ngoImagesURL: String, ratingsValue: Double, reviews: String, mondayHours: String, tuesdayHours: String, wedsDayHours: String, thursdayHours: String, fridayHours: String, saturdayHours: String, sundayHours: String, visitedDate: String){
//            self.ngoName = ngoName
//            self.ngoDescription = ngoDescription
//            self.ngoWebsite = ngoWebsite
//            self.ngoCategory = ngoCategory
//            self.ngoAcrimony = ngoAcrimony
//            self.ngoPhoneNumber = ngoPhoneNumber
//            self.ngoEmail = ngoEmail
//            self.ngoStreetAddress = ngoStreetAddress
//            self.ngoCity = ngoCity
//            self.ngoState = ngoState
//            self.ngoZipCode = ngoZipCode
//            self.contactPersonName = contactPersonName
//            self.ngoImagesURL = ngoImagesURL
//            self.ratingsValue = ratingsValue
//            self.reviews = reviews
//            self.mondayHours = mondayHours
//            self.tuesdayHours = tuesdayHours
//            self.wedsDayHours = wedsDayHours
//            self.thursdayHours = thursdayHours
//            self.fridayHours = fridayHours
//            self.saturdayHours = saturdayHours
//            self.sundayHours = sundayHours
//            self.visitedDate = visitedDate
//}
//
//    init(dict: [String: Any]) {
//        self.contactPersonName = dict[BookMarkedNGOCollectionKey.contactPersonName] as? String ?? ""
//        self.ngoDescription = dict[BookMarkedNGOCollectionKey.ngoDescription] as? String ?? "NGO does not have a description"
//        self.ngoWebsite = dict[BookMarkedNGOCollectionKey.ngoWebsite] as? String ?? "NGO does not have a registered website"
//        self.ngoCategory = dict[BookMarkedNGOCollectionKey.ngoCategory] as? String ?? "NGO does not specify category"
//        self.ngoAcrimony = dict[BookMarkedNGOCollectionKey.ngoAcrimony] as? String ?? "NGO does not have an acrimony"
//        self.ngoPhoneNumber = dict[BookMarkedNGOCollectionKey.ngoPhoneNumber] as? String ?? "NGO has no registered phone number"
//        self.ngoEmail = dict[BookMarkedNGOCollectionKey.ngoEmail] as? String ?? "NGO has no registered email address"
//        self.ngoStreetAddress = dict[BookMarkedNGOCollectionKey.ngoStreetAddress] as? String ?? "NGO does not have a registered street address"
//        self.ngoCity = dict[BookMarkedNGOCollectionKey.ngoCity] as? String ?? "NGO does not have a registered city"
//        self.ngoState = dict[BookMarkedNGOCollectionKey.ngoState] as? String ?? "NGO does not have a registered state"
//        self.ngoZipCode = dict[BookMarkedNGOCollectionKey.ngoZipCode] as? String ?? "NGO does not have a registered zipCode"
//
//        self.ngoImagesURL = dict[BookMarkedNGOCollectionKey.ngoImagesURL] as? String ?? "NGO does not have any images uploaded"
//        self.ratingsValue = dict[BookMarkedNGOCollectionKey.ratingsValue] as? Double ?? 0.0
//        self.reviews = dict[BookMarkedNGOCollectionKey.reviews] as? String ?? "NGO does not have any reviews yet"
//        self.mondayHours = dict[BookMarkedNGOCollectionKey.mondayHours] as? String ?? "NGO does not have open hours on monday"
//        self.tuesdayHours = dict[BookMarkedNGOCollectionKey.tuesdayHours] as? String ?? "NGO does not have open hours on tuesday"
//        self.wedsDayHours = dict[BookMarkedNGOCollectionKey.wedsDayHours] as? String ?? "NGO does not have open hours on wednesday"
//        self.thursdayHours = dict[BookMarkedNGOCollectionKey.thursdayHours] as? String ?? "NGO does not have open hours on thursday"
//        self.fridayHours = dict[BookMarkedNGOCollectionKey.fridayHours] as? String ?? "NGO does not have open hours on friday"
//        self.saturdayHours = dict[BookMarkedNGOCollectionKey.saturdayHours] as? String ?? "NGO does not have open hours on saturday"
//        self.sundayHours = dict[BookMarkedNGOCollectionKey.sundayHours] as? String ?? "NGO does not have open hours on sundays"
//        self.visitedDate = dict[BookMarkedNGOCollectionKey.bookMarkedDate] as? String ?? ""
//        self.ngoName = dict[BookMarkedNGOCollectionKey.ngoName] as? String ?? ""
//    }
//}
