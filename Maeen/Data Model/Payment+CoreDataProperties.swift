//
//  Payment+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 8/27/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var id: String?
    @NSManaged public var amount: Double
    @NSManaged public var status: String?
    @NSManaged public var currency: String?
    @NSManaged public var createdAt: Date?

}
