//
//  HomeContainer+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 10/4/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension HomeContainer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HomeContainer> {
        return NSFetchRequest<HomeContainer>(entityName: "HomeContainer")
    }

    @NSManaged public var section: Int32
    @NSManaged public var createdAt: Date?
}
