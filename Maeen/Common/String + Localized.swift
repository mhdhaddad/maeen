//
//  String + Localized.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
