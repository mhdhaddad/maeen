//
//  Subscription+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 8/11/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData

//{
//    "package_id": 0,
//    "name": "string",
//    "duration": 0,
//    "price": 0,
//    "extra_price": 0,
//    "off_price": 0,
//    "color": "string",
//    "services": [
//    {
//    "packaged_service_id": 0,
//    "service_id": 0,
//    "name": "string",
//    "unit": "string",
//    "icon": "string",
//    "quantity": 0
//    }
//    ]
//}
public class Subscription: NSManagedObject {
    convenience init(insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "Subscription")!, insertInto: context)
    }
    func insert(into context: NSManagedObjectContext?) {
        self.insert(into: context)
    }
    
    lazy var childrenNames: String =  {
        children.reduce("", { (result, name) -> String in
            if result.isEmpty {
                return name
            }else {
                return "\(result), \(name)"
            }
            
        })
    }()

    var isValid: Bool {
        guard expiresAt != nil && startsAt != nil else {
            return false
        }
        
        switch expiresAt!.compare(startsAt!) {
        case .orderedAscending:
            return false
        default:
            return true
        }
    }
}
extension Subscription /** + attributes */ {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        guard let id = attributes["id"] as? Int32, let packageId = attributes["package_id"] as? Int32, let childrenNames = attributes["children_names"] as? [String] else {
            return nil
        }
        
        self.init(insertInto: context)
        
        self.id = id
        self.packageId = packageId
        self.children = childrenNames
        
        if let type = attributes["package_name"] as? String {
            self.type = type
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let createdAtRaw = attributes["starts_at"] as? String {
            if let createdAt = formatter.date(from: createdAtRaw) {
                self.startsAt = createdAt
            }
        }
        
        if let expiresAtRaw = attributes["expires_at"] as? String {
            if let expiresAt = formatter.date(from: expiresAtRaw) {
                self.expiresAt = expiresAt
            }
        }
    }
}

