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
        API.posts.fetch { (result:Result<PostsFetchResult>) in
            guard case let .success(value) = result, let context = self.persistentContainer?.viewContext else { return }
            
            context.performChanges(inBlock: {
                value.forEach { _ = Post.insertInto(managedObjectContext: context, data: $0) }
            })
        }
    }
}

extension AppCoordinator:PostsTableViewControllerDelegate {
    func postsTableViewControllerDelegate(postsTableViewController: PostsTableViewController, didSelectPost post: Post) {
        detailController.configure(post: post)
    }
}
