//
//  GoogleAddressModel.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/3/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation


struct GoogleAddressModel: Codable {

    let results: [GoogleAddressResultsWrapper]

}

struct GoogleAddressResultsWrapper: Codable {
    let formatted_address: String
    let geometry: GeometryWrappers
}

struct GeometryWrappers: Codable {
    let location: locationDetails
}

struct locationDetails: Codable {
    let lat: Double
    let lng: Double
}
