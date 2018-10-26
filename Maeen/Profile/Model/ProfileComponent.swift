//
//  ProfileComponent.swift
//  Maeen
//
//  Created by yahya alshaar on 9/24/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation
import UIKit

struct ProfileComponent {
    enum Kind: String {
        case personal = "personalInformation"
        case communication = "communicationInformation"
        case password = "changePassword"
        case support = "technicalSupport"
        case signOut = "signOut"
    }
    
    var title: String? {
        return kind.rawValue.localized()
    }
    var icon: UIImage?
    var kind: Kind!
}
extension ProfileComponent {
    static var components: [ProfileComponent] {
        return [
            ProfileComponent(icon: #imageLiteral(resourceName: "profileIcon").withRenderingMode(.alwaysTemplate), kind: .personal),
            ProfileComponent(icon: #imageLiteral(resourceName: "emailIcon").withRenderingMode(.alwaysTemplate), kind: .communication),
            ProfileComponent(icon: #imageLiteral(resourceName: "passwordIcon").withRenderingMode(.alwaysTemplate), kind: .password),
            ProfileComponent(icon: #imageLiteral(resourceName: "technicalSupportIcon"), kind: .support),
            ProfileComponent(icon: #imageLiteral(resourceName: "signOutIcon"), kind: .signOut)
        ]
    }
}
