//
//  DateFormatter + Standard.swift
//  Maeen
//
//  Created by yahya alshaar on 9/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

extension DateFormatter {
    class var standard: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter
    }
}
