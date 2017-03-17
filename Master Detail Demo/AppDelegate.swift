//
//  AppDelegate.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var persistentContainer:NSPersistentContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NSPersistentContainer.setup { (container) in
            self.persistentContainer = container
            guard let postsController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: PostsTableViewController.name) as? PostsTableViewController else { return }
            postsController.managedObjectContext = container.viewContext
            self.window?.rootViewController = postsController
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

