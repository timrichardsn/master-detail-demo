//
//  AlbumsTableViewController.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit
import CoreData

class AlbumsTableViewController: UITableViewController {
    
    var managedObjectContext:NSManagedObjectContext?
    var fetchedResultsController:NSFetchedResultsController<Album>?
    var viewModel:AlbumsViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

// MARK: - AlbumsViewModelDelegate
extension AlbumsTableViewController: AlbumsViewModelDelegate {
    func albumsViewModel(albumsViewModel: AlbumsViewModel, showAlbumsByUser userId: Int16) {
        guard let managedObjectContext = managedObjectContext else { fatalError("No managed object context") }
        
        let request = Album.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "%K.%K > %lu", #keyPath(Album.user), #keyPath(User.userId), userId)
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension AlbumsTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { fatalError("New index path should be not nil") }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            guard let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell else { break }
            let album = fetchedResultsController?.object(at: indexPath)
            //cell.configure(withPost: post)
        case .move:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            guard let newIndexPath = newIndexPath else { fatalError("New index path should be not nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
