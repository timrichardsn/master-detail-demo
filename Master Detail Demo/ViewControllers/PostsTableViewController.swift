//
//  PostsTableViewController.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit
import CoreData

class PostsTableViewController: UITableViewController {

    var managedObjectContext:NSManagedObjectContext!
    var fetchedResultsController:NSFetchedResultsController<Post>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = Post.sortedFetchRequest
        request.fetchBatchSize = 20
        request.returnsObjectsAsFaults = false
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        try! fetchedResultsController?.performFetch()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController?.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = fetchedResultsController?.object(at: indexPath)
        // unimplemented cell type: TODO
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? UITableViewCell else { fatalError("Unable to create cell") }
        return cell
    }

}

//MARK: - NSFetchedResultsControllerDelegate

extension PostsTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}
