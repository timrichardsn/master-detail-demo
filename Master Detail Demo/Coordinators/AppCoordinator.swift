//
//  AppCoordinator.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit
import CoreData

class AppCoordinator {
    var splitController:UISplitViewController?
    var persistentContainer:NSPersistentContainer?
}

extension AppCoordinator {
    func start(window:UIWindow?) {
        NSPersistentContainer.setup { (container) in
            self.persistentContainer = container
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplitViewController")
        }
    }
}
