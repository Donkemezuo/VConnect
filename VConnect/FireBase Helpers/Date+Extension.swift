//
//  Date+Extension.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

extension Date {
    // get an ISO timestamp
    static func getISOTimestamp() -> String {
        let formatter = DateFormatter()
       formatter.dateFormat = "MMMM yyyy"
        let userJoinedDate = formatter.string(from: Date())
        return userJoinedDate
    }
    
    static func customizedDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let userJoinedDate = formatter.string(from: Date())
        return userJoinedDate

    }
}
