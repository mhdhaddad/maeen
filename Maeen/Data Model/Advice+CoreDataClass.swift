//
//  Advice+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 7/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


public class Advice: HomeContainer {

    convenience init(insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "Advice")!, insertInto: context)
        sectionKind = SectionKind.advice
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
    
    var since: String? {
        guard let date = createdAt else {
            return nil
        }
        
        return TimeLocalization.since(date: date)
    }
    var displayedRating: String? {
        guard rating > 0 else {
            return nil
        }
        
        return "\(rating)/5"
    }
}

extension Advice /** +attributes */ {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        guard let id = attributes["advice_id"] as? Int32, let childId = attributes["child_id"] as? Int32 else {
            return nil
        }
        
        self.init(insertInto: context)
        
        self.id = id
        self.childId = childId
        
        if let age = attributes["age"] as? Double {
            self.age = age
        }

        if let category = attributes["category"] as? String {
            self.category = category
        }
        
        if let title = attributes["title"] as? String {
            self.title = title
        }
        
        if let week = attributes["week"] as? Int32 {
            self.week = week
        }
        
        if let concept = attributes["concept"] as? String {
            self.concept = concept
        }

        if let snippet = attributes["snippet"] as? String {
            self.snippet = snippet
        }
        
        if let createdAtRaw = attributes["created_at"] as? String {
            
            self.createdAt = DateFormatter.standard.date(from: createdAtRaw)
        }
    }
}
