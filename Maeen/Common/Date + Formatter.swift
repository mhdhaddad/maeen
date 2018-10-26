//
//  Date + Formatter.swift
//  Maeen
//
//  Created by yahya alshaar on 8/31/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

extension Date {
    var displayed: String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
