//
//  Child+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 7/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


public class Child: Person {
    
    enum Relationship: EnumerationChoiceId, EnumerationChoice {
        case sun = 1
        case brother = 2
        case student = 3
        case neighbor = 4
        case grandson = 5
        case friend = 6
        case orphan = 7
        
        var displayed: String? {
            switch self {
            
            case .sun:
                return "sunOrDaughter".localized()
            case .brother:
                return "brotherOrSister".localized()
            case .student:
                return "schoolBoyOrGirl".localized()
            case .neighbor:
                return "neighbor".localized()
            case .grandson:
                return "grandsonOrDaughter".localized()
            case .friend:
                return "friend".localized()
            case .orphan:
                return "orphan".localized()
            }
        }
    }
    func insert(into context: NSManagedObjectContext?) {
        context?.insert(self)
    }
    
    
    var displayedConsulatationsCount: String {
        return "\(consultationCount)\n\("consultations".localized())"
    }
    var displayedAdvicesCount: String {
        return "\(adviceCount)\n\("receivedAdvices".localized())"
    }
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public override init?(entity: NSEntityDescription, attributes: [AnyHashable : Any], insertInto context: NSManagedObjectContext?) {
        
        guard let userId = attributes["user_id"] as? Int32 else {
            return nil
        }
        
        super.init(entity: entity, attributes: attributes, insertInto: context)
        
        self.userId = userId
        
        if let relationship = attributes["relationship"] as? String {
            self.relationship = relationship
        }
        
        if let relationship = attributes["relationship"] as? String {
            self.relationship = relationship
        }
        
        if let siblings = attributes["siblings"] as? Int16 {
            self.siblings = siblings
        }
        
        if let adviceCount = attributes["advice_count"] as? Int32 {
            self.adviceCount = adviceCount
        }
        
        if let consultationCount = attributes["consultation_count"] as? Int32 {
            self.consultationCount = consultationCount
        }

    }
}
extension Child {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "Child")!, attributes: attributes, insertInto: context)
    }
}
