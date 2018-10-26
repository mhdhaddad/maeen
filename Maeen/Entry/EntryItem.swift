//
//  EntryItem.swift
//  Maeen
//
//  Created by yahya alshaar on 5/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation
typealias EnumerationChoiceId = Int
protocol EnumerationChoice {
    var displayed: String? {get}
}

class EntryItem {
    var key: String!
    var value: EntryOption?
    var icon: String?
    var title: String?
    
    var kind: Kind!
    
    init(key: String, kind: Kind = .text, icon: String?, title: String? = nil, value: EntryOption? = nil) {
        self.key = key
        self.kind = kind
        self.icon = icon
        
        if title == nil {
            self.title = key.localized()
        }else {
            self.title = title
        }
        self.value = value
    }
    
    enum Kind {
        case email
        case text
        case password
        case firstName
        case lastName
        case sex
        case dateOfBirth
        case relationship
        case numberOfSibling
    }
}

protocol EntryOption {
    var displayed: String? {get set}
    var rawValue: Any { get set}
}

struct EntryValue: EntryOption {
    var rawValue: Any
    
    var displayed: String?
    
    init(value: Any) {
        self.init(value: value, displayed: "\(value)")
    }
    
    init(value: Any, displayed: String?) {
        self.rawValue = value
        self.displayed = displayed
    }
}

struct EnumValue: EntryOption {
    var displayed: String?
    
    var rawValue: Any
    
    init<T : RawRepresentable>(_ _enum: T) where T.RawValue == EnumerationChoiceId {
        
        rawValue = _enum.rawValue
        displayed = (_enum as! EnumerationChoice).displayed
    }
}
class EntryValidation {
    class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    class func isValidPhoneNumber(string: String) -> Bool {
        let phoneRegEx = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: string)
    }
}
