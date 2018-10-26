//
//  ConsultationReply+CoreDataProperties.swift
//  Maeen
//
//  Created by yahya alshaar on 9/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


extension ConsultationReply {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsultationReply> {
        return NSFetchRequest<ConsultationReply>(entityName: "ConsultationReply")
    }

    @NSManaged public var id: Int32
    @NSManaged public var consultationId: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var userName: String?
    @NSManaged public var text: String?
    @NSManaged public var createdAt: Date?

}
