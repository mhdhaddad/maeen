//
//  TotalItem.swift
//  Maeen
//
//  Created by yahya alshaar on 9/14/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

struct CustomPrice {
    var amount: Double = 0
    var currency: String?
    
    var displayed: String {
        var substring = Substring("\(amount)")
        
        if let currency = currency {
            substring.append(contentsOf: " ")
            substring.append(contentsOf: currency)
        }
        
        return String(substring)
    }
}
extension CustomPrice {
    init(attributes: [AnyHashable: Any]) {
        if let amount = attributes["price"] as? Double {
            self.amount = amount
        }
        
        if let currency = attributes["currency"] as? String {
            self.currency = currency
        }
    }
}

protocol Total {
    var title: String { get set }
    var price: CustomPrice { get set }
}

struct ChildTotal: Total {
    var price: CustomPrice
    var title: String

    init?(attributes: [AnyHashable: Any]) {
        guard let name = attributes["name"] as? String else {
            return nil
            
        }
        self.title = name
        self.price = CustomPrice(attributes: attributes)
        
        
    }
    
    
}

struct ItemTotal: Total {
    var title: String
    var price: CustomPrice
}
