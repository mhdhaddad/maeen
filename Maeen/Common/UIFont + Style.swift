//
//  UIFont + Style.swift
//  Maeen
//
//  Created by yahya alshaar on 6/9/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

let AdirBold = "29LTAdir-Bold"
let AdirMeduim = "29LTAdir-Medium"
let DubaiBold = "Dubai-Bold"

extension UIFont {
    enum Kind {
        case largeTitle
        case header
        case text
        case title1
        case title2
        case title2r
        case title3
        case subTitle1
        case subTitle2
        case subTitle3
        case subTitle4
        case body
        case secondryAction
        case action
        case menuLevelZero
        case menuLevel1
        case menuLevel2
        case menuLevel3
        case segment
        
    }
    
    
    class func font(from kind: UIFont.Kind) -> UIFont {
        switch kind {
        case .largeTitle:
            return UIFont(name: DubaiBold, size: 24)!
        case .header:
            return UIFont(name: AdirBold, size: 20)!
        case .text:
            return UIFont(name: AdirMeduim, size: 15)!
        case .title1:
            return UIFont(name: AdirBold, size: 18)!
//            return UIFont.systemFont(ofSize: 34, weight: .semibold)
        case .title2:
            return UIFont(name: AdirBold, size: 16)!
        case .title2r:
            return UIFont.systemFont(ofSize: 24, weight: .regular)
        case .title3:
            return UIFont.systemFont(ofSize: 14, weight: .semibold)
        case .subTitle1:
            return UIFont(name: AdirMeduim, size: 14)!
        case .subTitle2:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        case .subTitle3:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        case .subTitle4:
            return UIFont.systemFont(ofSize: 12, weight: .thin)
        case .body:
            return UIFont(name: AdirMeduim, size: 16)!
        case .secondryAction:
            return UIFont(name: AdirMeduim, size: 16)!
        case .action:
            return UIFont(name: AdirBold, size: 16)!
        case .menuLevelZero:
            return UIFont.systemFont(ofSize: 16, weight: .bold)
        case .menuLevel1:
            return UIFont.systemFont(ofSize: 15, weight: .medium)
        case .menuLevel2:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .menuLevel3:
            return UIFont.systemFont(ofSize: 15, weight: .thin)
        case .segment:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
//            return UIFont(name: "Adir-Bold", size: 25)!
        }
    }
}
