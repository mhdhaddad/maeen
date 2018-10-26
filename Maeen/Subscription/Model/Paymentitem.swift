//
//  PaymentItem.swift
//  Maeen
//
//  Created by yahya alshaar on 9/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

struct PaymentItem {
    var logo: UIImage!
    var title: String!
    var id: String!
}
extension PaymentItem {
    static var items: [PaymentItem] {
        return [
            PaymentItem(logo: #imageLiteral(resourceName: "mastercardLogo"), title: "creditCard".localized(), id: "creditcard"),
            PaymentItem(logo: #imageLiteral(resourceName: "kNetLogo"), title: "knet".localized(), id: "knet"),
            PaymentItem(logo: #imageLiteral(resourceName: "paypalLogo"), title: "Paypal".localized(), id: "paypal"),
            
        ]
    }
}
