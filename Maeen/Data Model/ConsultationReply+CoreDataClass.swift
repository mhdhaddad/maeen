//
//  ConsultationReply+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 9/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData
import MessageKit

public class ConsultationReply: NSManagedObject {
    convenience init(insertInto context: NSManagedObjectContext?) {
        self.init(entity: app.handler.entityDescription(entityName: "ConsultationReply")!, insertInto: context)
    }
    
    lazy var sender: Sender = {
        return Sender(id: "\(userId)", displayName: userName ?? "")
    }()
    lazy var message: ConsultationMessage =  {
        ConsultationMessage(text: text ?? "", sender: sender, messageId: "\(id)", date: createdAt ?? Date())
    }()
}
extension ConsultationReply /** +attributes */ {
    convenience init?(attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        guard let id = attributes["id"] as? Int32 else {
            return nil
        }
        
        self.init(insertInto: context)
        self.id = id
        
        if let consultationId = attributes["consultation_id"] as? Int32 {
            self.consultationId = consultationId
        }
        
        if let userId = attributes["user_id"] as? Int32 {
            self.userId = userId
        }
        
        if let message = attributes["message"] as? String {
            self.text = message
        }
        
        if let rawCreatedAt = attributes["created_at"] as? String {
            createdAt = DateFormatter.standard.date(from: rawCreatedAt)
        }
    }
}

internal struct ConsultationMessage: MessageType {
    var sender: Sender
    
    var messageId: String
    
    var sentDate: Date
    
    var data: MessageData
    
    private init(kind: MessageData, sender: Sender, messageId: String, date: Date) {
        self.data = kind
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }
    
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, date: date)
    }
}
