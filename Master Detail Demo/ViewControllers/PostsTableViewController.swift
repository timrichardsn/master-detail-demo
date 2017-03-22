//
//  PostsTableViewController.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit
import CoreData

protocol PostsTableViewControllerDelegate:class {
    func postsTableViewControllerDelegate(postsTableViewController:PostsTableViewController, didSelectPost post:Post)
}

class PostsTableViewController: UITableViewController {

    var managedObjectContext:NSManagedObjectContext!
    weak var delegate:PostsTableViewControllerDelegate?
    
    fileprivate lazy var fetchedResultsController:NSFetchedResultsController<Post> = {
        let request = Post.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        try! fetchedResultsController.performFetch()
    }
}

//MARK: - NSFetchedResultsControllerDelegate

extension PostsTableViewController: NSFetchedResultsControllerDelegate {
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
            let post = fetchedResultsController.object(at: indexPath)
            cell.configure(withPost: post)
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

// MARK: - UITableViewDelegate

extension PostsTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.configure(withPost: post)
        return cell
    }
}

// MARK: - UITableViewDataSource

extension PostsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = fetchedResultsController.object(at: indexPath)
        delegate?.postsTableViewControllerDelegate(postsTableViewController: self, didSelectPost: post)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let post = self.fetchedResultsController.object(at: indexPath)
            post.delete()
        }
        return [deleteAction]
    }
}
