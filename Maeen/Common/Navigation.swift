//
//  Navigation.swift
//  Maeen
//
//  Created by yahya alshaar on 5/27/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class Navigation {
    class func password() -> UIViewController {
        let vc = welcoming.instantiateViewController(withIdentifier: "passwordVC")
        return vc
    }
    class func email() -> UIViewController {
        let vc = welcoming.instantiateViewController(withIdentifier: "emailVC")
        return vc
    }
    class func phoneNumber() -> UIViewController {
        let vc = welcoming.instantiateViewController(withIdentifier: "phoneNumberVC")
        return vc
    }
    class func verifyPhoneNumber() -> UIViewController {
        let vc = welcoming.instantiateViewController(withIdentifier: "verifyPhoneNumberVC")
        return vc
    }
    class func stage(destination: UIViewController) -> UIViewController {
        let vc = welcoming.instantiateViewController(withIdentifier: "stageVC") as! WelcomingStageViewContainer
        vc.destination = destination
        return vc
    }
    class func signIn() -> UIViewController {
        return welcoming.instantiateViewController(withIdentifier: "signInVC")
    }
    class func welcome(context: WelcomingViewController.ContextKind = .root) -> UINavigationController {
        let vc = welcoming.instantiateViewController(withIdentifier: "welcomeVC") as! WelcomingViewController
        vc.context = context
        
        return UINavigationController(rootViewController: vc)
    }
    class func home() -> UIViewController {
        return main.instantiateInitialViewController()!
    }
    
    class func consualtation() {
        
    }
}
extension Navigation /** +storyboard */ {
    fileprivate class var welcoming: UIStoryboard {
        return UIStoryboard(name: "Welcoming", bundle: nil)
    }
    fileprivate class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
