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
    fileprivate lazy var detailViewModel = DetailViewModel()
    fileprivate lazy var albumsViewModel = AlbumsViewModel()
    
    fileprivate lazy var detailController:DetailViewController = {
        let detailController:DetailViewController = DetailViewController.instance(in: .main)
        detailController.viewModel = self.detailViewModel
        detailController.delegate = self
        return detailController
    }()
    
    fileprivate lazy var postsController:PostsTableViewController = {
        let p:PostsTableViewController = PostsTableViewController.instance(in: .main)
        p.delegate = self
        return p
    }()
    
    var syncCoordinator:SyncCoordinator?
}

extension AppCoordinator {
    func start(window:UIWindow?) {
        NSPersistentContainer.setup { (container) in
            self.syncCoordinator = SyncCoordinator(persistentContainer: container)
            
            self.postsController.managedObjectContext = self.syncCoordinator?.mainContext
            self.splitController.viewControllers = [UINavigationController(rootViewController: self.postsController), self.detailController]
            
            window?.rootViewController = self.splitController
            self.fetchData()
        }
    }
    
    func fetchData() {
        API.users.fetch { (result) in
            self.performChangesWithApiData(result: result, callback: { (data, context) in
                _ = User.findOrCreate(withData: data, in: context)
            })
            
            API.posts.fetch { (result) in
                self.performChangesWithApiData(result: result, callback: { (data, context) in
                    _ = Post.findOrCreate(withData: data, in: context)
                })
            }
        }
        
        API.albums.fetch { (result) in
            self.performChangesWithApiData(result: result, callback: { (data, context) in
                _ = Album.findOrCreate(withData: data, in: context)
            })
        }
        
        API.photos.fetch { (result) in
            self.performChangesWithApiData(result: result, callback: { (data, context) in
                _ = Photo.findOrCreate(withData: data, in: context)
            })
        }
    }
}

// MARK: - Private
fileprivate extension AppCoordinator {
    func performChangesWithApiData(result:Result<APIFetchResult>, callback:@escaping (APIData, NSManagedObjectContext) -> ()) {
        guard case let .success(value) = result, let context = syncCoordinator?.backgroundContext else { return }
        context.performChanges(inBlock: {
            value.forEach { callback($0, context) }
        })
    }
}

// MARK: - PostsTableViewControllerDelegate
extension AppCoordinator: PostsTableViewControllerDelegate {
    func postsTableViewControllerDelegate(postsTableViewController: PostsTableViewController, didSelectPost post: Post) {
        detailViewModel.configure(with: post)
        albumsViewModel.configure(with: post)
    }
}

// MARK: - DetailViewControllerDelegate
extension AppCoordinator: DetailViewControllerDelegate {
    func detailViewController(detailViewController: DetailViewController, prepare albumsController: AlbumsTableViewController) {
        albumsController.managedObjectContext = syncCoordinator?.mainContext
        albumsController.viewModel = albumsViewModel
        
    }
}
