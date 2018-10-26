//
//  Utility.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation


class Utility {
    class func countries() -> [String: String] {
        var countries: [String: String] = [:]
        countries.reserveCapacity(Locale.isoRegionCodes.count)
        
        for code in Locale.isoRegionCodes as [String] {
            if let name = countryName(code: code) {
                countries[code] = name
            }
        }
        return countries
    }
    
    class func countryName(code: String) -> String? {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: "\(id)") //?.slice(from: "(", to: ")")
    }
}
