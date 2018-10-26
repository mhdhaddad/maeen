//
//  Package+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 8/11/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Package: NSManagedObject {
    convenience init(insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "Package")!, insertInto: context)
    }
    
    lazy var details: String? = {
        return services.reduce("", { (result, string) -> String in
            
            var substring = Substring(result)
            if result.isEmpty == false {
                substring.append(contentsOf: "\n")
            }
            
            substring.append(contentsOf: string)
            return String(substring)
        })
    }()
    
    lazy var priceComponent: PriceComponent! = {
        return PriceComponent(new: offPrice, old: price)
    }()
    struct PriceComponent {
        var new: Price!
        var old: Price!
    
    }
    
    lazy var color: UIColor =  {
        let defaultColor = UIColor.tint
        
        
        guard hexColor != nil else {
            return defaultColor
        }
        
        return UIColor.hexStringToUIColor(hex: hexColor!) ?? defaultColor
    }()
    
    var subscriptionPeriod: String {
        return "yearly".localized()
    }
}

extension Package /** +attributes */ {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        guard let id = attributes["id"] as? Int32 else {
            return nil
        }
        
        self.init(insertInto: context)
        self.id = id
        
        if let title = attributes["name"] as? String {
            self.title = title
        }
        
        if let price = attributes["price"] as? Double {
            self.price = price
        }
        
        if let extraPrice = attributes["extra_price"] as? Double {
            self.extraPrice = extraPrice
        }
        
        if let offPrice = attributes["off_price"] as? Double {
            self.offPrice = offPrice
        }
        
        if let hexColor = attributes["color"] as? String {
            self.hexColor = hexColor
        }
        
        services = []
        if let services = attributes["services"] as? [String] {
            self.services = services
        }
    }
}
extension Price {
    var displayed: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en-us")
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))
    }
}
