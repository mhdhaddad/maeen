//
//  EntryItem + Parameters.swift
//  Maeen
//
//  Created by yahya alshaar on 10/13/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation
import Alamofire

//extension EntryItem {
//    var parameters: Parameters {
//        return [key: value?.rawValue ?? ""]
//    }
//}

extension Array where Element: EntryItem {
    var paramters: Parameters {
        return reduce([:]) { (result, element) -> Parameters in
            
            var result = result
            if let value = element.value?.rawValue {
                result[element.key] = value
            }
            return result
        }
    }
}
