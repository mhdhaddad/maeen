//
//  Person+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 9/28/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Person)
public class Person: NSManagedObject {
    
    var name: String? {
        var substring = Substring()
        
        if let firstName = firstName {
            substring.append(contentsOf: firstName)
        }
        
        if let lastName = lastName {
            if substring.isEmpty == false {
                substring.append(contentsOf: " ")
            }
            
            substring.append(contentsOf: lastName)
        }
        
        return String(substring)
    }

    
    var age: Int? {
        guard let d = birthDate else { return nil }
        let calendar = Calendar.current
        return calendar.dateComponents([.year], from: d, to: Date()).year
    }
    
    var displayedAge: String? {
        guard let age = age else {
            return nil
        }
        var years = "years".localized()
        if age == 1 {
            years = "oneYear".localized()
        }else if age == 2 {
            years = "twoYears".localized()
        }else if age > 2 && age < 11 {
            years = "moreThan2Years".localized()
        }
        
        return "\(age) \(years)"
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    public init?(entity: NSEntityDescription, attributes: [AnyHashable: Any], insertInto context: NSManagedObjectContext?) {
        
        guard let id = attributes["id"] as? Int32 else {
            return nil
        }
        
        super.init(entity: entity, insertInto: context)
        
        self.id = id
        
        if let birthdateString = attributes["birthdate"] as? String {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let birthdate = formatter.date(from: birthdateString) {
                self.birthDate = birthdate
            }
        }
        
        
        if let firstName = attributes["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = attributes["last_name"] as? String {
            self.lastName = lastName
        }
        
        if let gender = attributes["gender"] as? String {
            self.gender = gender
        }
        
        if let nationality = attributes["nationality"] as? String {
            self.nationality = nationality
        }
        
        if let image = attributes["image"] as? String {
            self.imageURL = URL(string: image)
        }
        
    }
}

//extension Person /** +attributes */ {
//    convenience init?(attributes: [AnyHashable: Any]) {
//
//        guard let id = attributes["id"] as? Int32 else {
//            return nil
//        }
//        self.init(attributes: attributes)
//
//        self.id = id
//
//        if let birthdateString = attributes["birthdate"] as? String {
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            if let birthdate = formatter.date(from: birthdateString) {
//                self.birthDate = birthdate
//            }
//        }
//
//
//        if let firstName = attributes["first_name"] as? String {
//            self.firstName = firstName
//        }
//
//        if let lastName = attributes["last_name"] as? String {
//            self.lastName = lastName
//        }
//
//        if let gender = attributes["gender"] as? String {
//            self.gender = gender
//        }
//
//        if let nationality = attributes["nationality"] as? String {
//            self.nationality = nationality
//        }
//
//        if let image = attributes["image"] as? String {
//            self.imageURL = URL(string: image)
//        }
//
//    }
//}
extension Person /** +UIImage */ {
    var placeholderImage: UIImage {
        if gender?.lowercased().elementsEqual("m") ?? false || gender?.contains("male") ?? true {
            return #imageLiteral(resourceName: "boyAvatar")
        }else {
            return #imageLiteral(resourceName: "girlAvatar")
        }
    }
}
