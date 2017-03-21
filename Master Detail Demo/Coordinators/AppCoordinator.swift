//
//  AppCoordinator.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit
import CoreData

final class AppCoordinator {
    fileprivate lazy var splitController = UISplitViewController()
    fileprivate lazy var detailController:DetailViewController = DetailViewController.instance()
    fileprivate lazy var postsController:PostsTableViewController = {
        let p:PostsTableViewController = PostsTableViewController.instance()
        p.delegate = self
        return p
    }()
    
    fileprivate var persistentContainer:NSPersistentContainer?
}

extension AppCoordinator {
    func start(window:UIWindow?) {
        NSPersistentContainer.setup { (container) in
            self.persistentContainer = container
            
            self.postsController.managedObjectContext = container.viewContext
            self.splitController.viewControllers = [UINavigationController(rootViewController: self.postsController), self.detailController]
            
            window?.rootViewController = self.splitController
            self.fetchPosts()
        }
    }
    
    func fetchPosts() {
        API.posts.fetch { (result) in
            self.performChangesWithApiData(result: result, callback: { (data, context) in
                _ = Post.findOrCreate(withData: data, in: context)
            })
        }
        
        API.users.fetch { (result) in
            self.performChangesWithApiData(result: result, callback: { (data, context) in
                _ = User.findOrCreate(withData: data, in: context)
            })
        }
        
        API.albums.fetch { (result) in
            self.performChangesWithApiData(result: result, callback: { (data, context) in
                _ = Album.findOrCreate(withData: data, in: context)
            })
        }
    }
}

// MARK: - Private
fileprivate extension AppCoordinator {
    func performChangesWithApiData(result:Result<APIFetchResult>, callback:@escaping (APIData, NSManagedObjectContext) -> ()) {
        guard case let .success(value) = result, let context = persistentContainer?.viewContext else { return }
        context.performChanges(inBlock: {
            value.forEach { callback($0, context) }
        })
    }
}

// MARK: - PostsTableViewControllerDelegate
extension AppCoordinator:PostsTableViewControllerDelegate {
    func postsTableViewControllerDelegate(postsTableViewController: PostsTableViewController, didSelectPost post: Post) {
        detailController.configure(post: post)
    }
}
