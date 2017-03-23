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
    let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start(window: window)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //appCoordinator.fetchData()
    }
}

