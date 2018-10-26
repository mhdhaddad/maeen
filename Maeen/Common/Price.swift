//
//  Price.swift
//  Maeen
//
//  Created by yahya alshaar on 9/14/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

typealias Price = Double

extension Price {
    var localized: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        
        return formatter.string(from: NSNumber(value: self))
    }
}
