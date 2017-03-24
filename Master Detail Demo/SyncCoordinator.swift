//
//  SyncCoordinator.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation
import CoreData

final class SyncCoordinator: ContextObserver {
    let persistentContainer:NSPersistentContainer
    let mainContext:NSManagedObjectContext
    let backgroundContext:NSManagedObjectContext
    
    var observers: [NSObjectProtocol] = []
    
    init(persistentContainer:NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        setupObservers()
    }
    
    deinit {
        backgroundContext.perform { 
            self.removeObservers()
        }
    }
}

fileprivate extension SyncCoordinator {
    func setupObservers() {
        addObserver(
            backgroundContext.addContextObserver(forName: .NSManagedObjectContextDidSave, handler: { [weak self] (notification) in
                self?.mainContext.performMerge(fromContextDidSave: notification)
            })
        )
    }
}
