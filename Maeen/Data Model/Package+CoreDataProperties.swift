//
//  Package+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 8/21/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Package {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Package> {
        return NSFetchRequest<Package>(entityName: "Package")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var extraPrice: Double
    @NSManaged public var offPrice: Double
    @NSManaged public var hexColor: String?
    @NSManaged public var services: [String]!

}
