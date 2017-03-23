//
//  FetchedResultsController.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation
import CoreData

class FetchedResultsController {
    let managedObjectContext:NSManagedObjectContext
    
    init(managedObjectContext:NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
}
