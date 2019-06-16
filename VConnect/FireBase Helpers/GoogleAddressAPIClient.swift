  //
//  GoogleAddressAPIClient.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 6/3/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation
  
  final class GoogleAddressAPIClient {
    
    static func getAddressCoordinates(fullAddress: String, completionHandler: @escaping(AppError?, GoogleAddressModel?) ->  Void) {
    
    let endPoint = "https://maps.googleapis.com/maps/api/geocode/json?address=\(fullAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&key=\(SecretKeys.googleAddressesAPIKey)"
        NetworkHelper.shared.performDataTask(endpointURLString: endPoint) { (error, data) in
            if let appError = error {
                print("Error \(appError) encountered")
            } else if let fullAddress = data {
                do {
                    let fullAddressFromGoogle = try JSONDecoder().decode(GoogleAddressModel.self, from: fullAddress)
                    completionHandler(nil, fullAddressFromGoogle)
                } catch {
                }
            }
        }
        
        
    }
    
  }
