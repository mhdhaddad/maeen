//
//  User+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 9/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


public class User: Person {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public override init?(entity: NSEntityDescription, attributes: [AnyHashable : Any], insertInto context: NSManagedObjectContext?) {
        
        super.init(entity: entity, attributes: attributes, insertInto: context)
        
        if let country = attributes["country"] as? String {
            self.country = country
        }
        
        if let email = attributes["email"] as? String {
            self.email = email
        }
        
        if let mobile = attributes["mobile"] as? String {
            self.mobile = mobile
        }
        
        if let isMobileConfirmed = attributes["mobileConfirmed"] as? Bool {
            self.isMobileConfirmed = isMobileConfirmed
        }
        
        if let phone = attributes["phone"] as? String {
            self.phone = phone
        }
        
        if let socialStatus = attributes["socialStatus"] as? String {
            self.socialStatus = socialStatus
        }
        
        if let state = attributes["state"] as? String {
            self.state = state
        }
    }
}
extension User {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "User")!, attributes: attributes, insertInto: context)
    }
}
extension User /** +User defaults */ {
    var advicesCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "advices_count")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "advices_count")
        }
    }
    
    var consultationsCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "consultations_count")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "consultations_count")
        }
    }
    
    var displayedConsulatationsCount: String {
        return "\(consultationsCount)\n\("consultations".localized())"
    }
    var displayedAdvicesCount: String {
        return "\(advicesCount)\n\("receivedAdvices".localized())"
    }
    var displayedChildrenCount: String? {
        var count = 0
        let fetch: NSFetchRequest<NSFetchRequestResult> = Child.fetchRequest()
        do {
            count = try app.handler.moc.count(for: fetch)
        }catch {
            
        }
        
        if count < 1 {
            return nil
        }
        return "\(count)\n\("childrenCount".localized())"
    }
}
