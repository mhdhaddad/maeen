//
//  Person+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 9/28/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: String?
    @NSManaged public var nationality: String?
    @NSManaged public var imageURL: URL?
    @NSManaged public var birthDate: Date?
    @NSManaged public var id: Int32

}
