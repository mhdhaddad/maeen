//
//  Account.swift
//  Maeen
//
//  Created by yahya alshaar on 6/30/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation
import CoreData

class Account {
    var isGeust: Bool {
        return token == nil
    }
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "access_token")
        }
        get{
            if let _token = UserDefaults.standard.string(forKey: "access_token") {
                return "Bearer \(_token)"
            }
            return nil
        }
    }
    var user: User? {
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try app.handler.moc.fetch(fetch).first
        }catch let error {
            print(error)
            return nil
        }
    }
    
    func authentication(attributes: [AnyHashable: Any]) {
        if let token = attributes["token"] as? String {
            self.token = token
            
            Lookup.shared.profile(context: app.handler.moc, success: { (user) in
                
            }) { (error) in
                //TODO: handle error
            }
        }
    }
    
    func signOut() {
        token = nil
        
        let fetchUsers: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteUsers = NSBatchDeleteRequest(fetchRequest: fetchUsers)
        
        let fetchChildren: NSFetchRequest<NSFetchRequestResult> = Child.fetchRequest()
        let deleteChildren = NSBatchDeleteRequest(fetchRequest: fetchChildren)
        
        let fetchConsultations: NSFetchRequest<NSFetchRequestResult> = Consultation.fetchRequest()
        let deleteConsultations = NSBatchDeleteRequest(fetchRequest: fetchConsultations)
        
        let fetchAdvices: NSFetchRequest<NSFetchRequestResult> = Advice.fetchRequest()
        let deleteAdvices = NSBatchDeleteRequest(fetchRequest: fetchAdvices)
        
        
        do {
            let moc = app.handler.moc
            
            try moc.execute(deleteUsers)
            try moc.execute(deleteChildren)
            try moc.execute(deleteConsultations)
            try moc.execute(deleteAdvices)
        }catch {
            
        }
    }
}
