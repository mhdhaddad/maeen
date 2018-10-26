//
//  Advice+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 9/4/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Advice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Advice> {
        return NSFetchRequest<Advice>(entityName: "Advice")
    }

    @NSManaged public var age: Double
    @NSManaged public var category: String?
    @NSManaged public var childId: Int32
    @NSManaged public var concept: String?
    @NSManaged public var id: Int32
    @NSManaged public var snippet: String?
    @NSManaged public var title: String?
    @NSManaged public var week: Int32
    @NSManaged public var rating: Double

}
