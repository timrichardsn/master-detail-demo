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
            
            guard let splitController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplitViewController") as? UISplitViewController else { return }
            guard let nav = splitController.viewControllers[0] as? UINavigationController else { return }
            
            let postsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PostsTableViewController.name) as! PostsTableViewController
            postsController.managedObjectContext = container.viewContext
            nav.viewControllers = [postsController]
            
            window?.rootViewController = splitController
            self.fetchPosts()
        }
    }
}

fileprivate extension AppCoordinator {
    func fetchPosts() {
        API.posts.fetch(completion: { (result) in
            guard case let .success(value) = result, let context = self.persistentContainer?.viewContext else { return }
            
            context.performChanges(inBlock: {
                value.forEach { _ = Post.insertInto(managedObjectContext: context, data: $0) }
            })
        })
    }
}
