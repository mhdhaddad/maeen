//
//  Child+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 9/28/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Child {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    }

    @NSManaged public var adviceCount: Int32
    @NSManaged public var consultationCount: Int32
    @NSManaged public var relationship: String?
    @NSManaged public var siblings: Int16
    @NSManaged public var userId: Int32

}
