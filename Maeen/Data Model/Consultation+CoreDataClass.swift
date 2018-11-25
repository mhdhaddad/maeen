//
//  Consultation+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 7/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


public class Consultation: HomeContainer {
    convenience init(insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "Consultation")!, insertInto: context)
        sectionKind = SectionKind.consultation
    }
    
    func insert(into context: NSManagedObjectContext?) {
        context?.insert(self)
    }
    
    var child: Child? {
        let fetch: NSFetchRequest<Child> = Child.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %i", childId)
        do {
            return try app.handler.moc.fetch(fetch).first
        }catch let error {
            print(error)
            return nil
        }
    }
    var advice: Advice? {
        let fetch: NSFetchRequest<Advice> = Advice.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %i", adviceId)
        
        do {
            return try app.handler.moc.fetch(fetch).first
        }catch let error {
            print(error)
            return nil
        }
    }
    var since: String? {
        guard let date = createdAt else {
            return nil
        }
        
        return TimeLocalization.since(date: date)
    }
    
    var messages: [ConsultationReply] {
        let fetch: NSFetchRequest<ConsultationReply> = ConsultationReply.fetchRequest()
        fetch.predicate = NSPredicate(format: "consultationId == %i", id)
        
        do {
            return try app.handler.moc.fetch(fetch)
        }catch let error {
            print(error)
            return []
        }
    }
}

extension Consultation /** +attributes */ {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        guard let id = attributes["id"] as? Int32, let childId = attributes["child_id"] as? Int32 else {
            return nil
        }
        
        self.init(insertInto: context)
        
        self.id = id
        
        
        self.childId = childId
        
        if let adviceId = attributes["advice_id"] as? Int32 {
            self.adviceId = adviceId
        }
        
        if let title = attributes["title"] as? String {
            self.title = title
        }
        
        if let snippet = attributes["snippet"] as? String {
            self.snippet = snippet
        }
        
        if let createdAtRaw = attributes["created_at"] as? String {
            
            self.createdAt = DateFormatter.standard.date(from: createdAtRaw)
        }
        
        for messageAttributes in attributes["message"] as? [[AnyHashable: AnyHashable]] ?? [] {
            let c = ConsultationReply(attributes: messageAttributes, insertInto: context)
            c?.id
        }
    }
}
