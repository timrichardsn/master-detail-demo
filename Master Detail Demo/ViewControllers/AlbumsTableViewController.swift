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
    
    var managedObjectContext:NSManagedObjectContext!
    fileprivate var fetchedResultsController:NSFetchedResultsController<Album>?
    
    var viewModel:AlbumsViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let album = fetchedResultsController?.object(at: indexPath) else { fatalError("No album for index path") }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        cell.configure(with: album)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController?.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
}

// MARK: - AlbumsViewModelDelegate
extension AlbumsTableViewController: AlbumsViewModelDelegate {
    func albumsViewModel(albumsViewModel: AlbumsViewModel, showAlbumsByUser userId: Int16) {
        if fetchedResultsController == nil {
            let request = Album.sortedFetchRequest
            request.returnsObjectsAsFaults = false
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController?.delegate = self
        }
        
        fetchedResultsController?.fetchRequest.predicate = NSPredicate(format: "%K == %d", #keyPath(Album.userId), userId)
        try! fetchedResultsController?.performFetch()
        tableView.reloadData()
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
            guard let album = fetchedResultsController?.object(at: indexPath), let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell else { break }
            cell.configure(with: album)
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
