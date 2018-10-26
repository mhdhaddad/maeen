//
//  User+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 9/28/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var country: String?
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var isMobileConfirmed: Bool
    @NSManaged public var phone: String?
    @NSManaged public var socialStatus: String?
    @NSManaged public var state: String?

}
