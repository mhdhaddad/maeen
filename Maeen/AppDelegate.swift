
//
//  AppDelegate.swift
//  Maeen
//
//  Created by yahya alshaar on 5/23/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if app.account.isGeust == true {
            makeRoot(viewController: Navigation.welcome())
        }else {
            makeRoot(viewController: Navigation.home())
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Maeen")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
extension AppDelegate {
    func makeRoot(viewController: UIViewController) {
        var isOnboardingContext = false
        if (viewController.storyboard?.value(forKey: "name") as? String)?.lowercased() ?? "main" == "welcoming" {
            isOnboardingContext = true
        }
        defineNavigationBarStyle(isOnboardingContext: isOnboardingContext)
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
    }
    
    func defineNavigationBarStyle(isOnboardingContext: Bool) {
        if isOnboardingContext {
            // define navigation bar style
            UINavigationBar.appearance().barTintColor = UIColor.tint
            UINavigationBar.appearance().tintColor = UIColor.white
            
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont.font(from: .header)
            ]
            
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont.font(from: .action)
                ], for: [.normal, .highlighted, .selected, .disabled])
            
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedStringKey.font: UIFont.font(from: .largeTitle),
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
        }else {
            let textColor = UIColor.primary
            // define navigation bar style
            UINavigationBar.appearance().barTintColor = UIColor.white
            UINavigationBar.appearance().tintColor = textColor
            
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: textColor,
                NSAttributedStringKey.font: UIFont.font(from: .header)
            ]
            
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont.font(from: .action)
                ], for: .normal)
            
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont.font(from: .action)
                ], for: .selected)
            
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont.font(from: .action)
                ], for: .highlighted)
            
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont.font(from: .action)
                ], for: .disabled)
            
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedStringKey.font: UIFont.font(from: .largeTitle),
                NSAttributedStringKey.foregroundColor: textColor
            ]
            
            
        }
    }
}

