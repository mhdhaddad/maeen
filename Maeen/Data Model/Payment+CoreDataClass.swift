//
//  Payment+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 8/27/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


public class Payment: NSManagedObject {
    convenience init(insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "Payment")!, insertInto: context)
    }
    
    func inseart(into context: NSManagedObjectContext?) {
        context?.insert(self)
    }
    
    var details: String? {
        
        guard let _currency = currency else {
            return nil
        }
        
        return "\(amount) \(_currency)"
    }
    
    lazy var displayedDate: String? = {
        guard let date = createdAt else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }()
    
    var displayedAmount: String {
        let amountString = String(format: "%.2d", amount)
        var substring = Substring(amountString)
        
        if let currency = currency {
            substring.append(contentsOf: " ")
            substring.append(contentsOf: currency)
        }
        
        return String(substring)
    }
}
extension Payment /** +attributes */ {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        
        guard let id = attributes["track_id"] as? String else {
            return nil
        }
        
        self.init(insertInto: context)
        
        self.id = id
        
        if let amount = attributes["amount"] as? Double {
            self.amount = amount
        }
        
        if let currency = attributes["currency"] as? String {
            self.currency = currency
        }
        
        if let status = attributes["status"] as? String {
            self.status = status
        }
        
        if let rawCreatedAt = attributes["created_at"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            createdAt = formatter.date(from: rawCreatedAt)
        }
    }
}
