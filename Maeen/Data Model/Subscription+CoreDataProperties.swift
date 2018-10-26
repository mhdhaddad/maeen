//
//  Subscription+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 8/11/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Subscription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subscription> {
        return NSFetchRequest<Subscription>(entityName: "Subscription")
    }

    @NSManaged public var children: [String]!
    @NSManaged public var startsAt: Date?
    @NSManaged public var expiresAt: Date?
    @NSManaged public var id: Int32
    @NSManaged public var packageId: Int32
    @NSManaged public var type: String?

}
