//
//  EntryItem.swift
//  Maeen
//
//  Created by yahya alshaar on 5/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

class EntryItem {
    var key: String!
    var value: String?
    var icon: String?
    
    var kind: Kind!
    
    init(key: String, kind: Kind = .text, icon: String?) {
        self.key = key
        self.kind = kind
        self.icon = icon
    }
    
    var title: String {
        return key.localized()
    }
    enum Kind {
        case email
        case text
    }
}
