//
//  Consultation+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 9/4/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Consultation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Consultation> {
        return NSFetchRequest<Consultation>(entityName: "Consultation")
    }

    @NSManaged public var adviceId: Int32
    @NSManaged public var childId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var snippet: String?
    @NSManaged public var title: String?

}
