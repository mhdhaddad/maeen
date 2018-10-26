//
//  Time + Localization.swift
//  Maeen
//
//  Created by yahya alshaar on 8/31/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

class TimeLocalization {
    class func minute(_ minute: Int) -> String {
        var localizedMinute: String!
        if minute == 1 {
            localizedMinute = "minute".localized()
        }else if minute == 2 {
            localizedMinute = "2Minutes".localized()
        }else if minute > 2 && minute < 11 {
            localizedMinute = "moreThan2Minutes".localized()
        }else {
            localizedMinute = "minute".localized()
        }
        
        return localizedMinute
    }
    
    class func hour(_ hour: Int) -> String {
        var localizedHour: String!
        if hour == 1 {
            localizedHour = "hour".localized()
        }else if hour == 2 {
            localizedHour = "2Hours".localized()
        }else if hour > 2 && hour < 11 {
            localizedHour = "moreThan2Hours".localized()
        }else {
            localizedHour = "hour".localized()
        }
        
        return localizedHour
    }
    
    class func since(date: Date) -> String? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: Date())
        if let hour = components.hour, hour > 0 {
            if hour < 24 {
                return "\(hour) \(TimeLocalization.hour(hour))"
            }else {
                return date.displayed
            }
        }else if let minute = components.minute, minute > 0 {
            return "\(minute) \(TimeLocalization.minute(minute))"
        }else {
            return "sinceNow".localized()
    }
    }
}
