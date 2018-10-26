//
//  HomeContainer+CoreDataClass.swift
//  Maeen
//
//  Created by yahya alshaar on 9/4/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//
//

import Foundation
import CoreData


public class HomeContainer: NSManagedObject {

    enum SectionKind: Int32 {
        case advice = 0
        case consultation = 1
    }
    
    var sectionKind: SectionKind {
        get {
            return SectionKind(rawValue: section)!
        }
        set {
            section = newValue.rawValue
        }
    }
}
