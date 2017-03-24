//
//  ManagedModelObserver.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 24/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation
import CoreData

final class ManagedModelObserver: ContextObserver {
    
    enum Change {
        case updated
    }
    
    var observers = [NSObjectProtocol]()
    
    deinit {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        removeObservers()
    }
    
    init(model:NSManagedObject, handler: @escaping (ManagedModelObserver.Change) -> ()) {
        
        guard let context = model.managedObjectContext else { fatalError("No context on the model") }
        
        addObserver(
            context.addContextObserver(forName: .NSManagedObjectContextObjectsDidChange, handler: { (notification) in
                
                let updated = notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject> ?? []
                let refreshed = notification.userInfo?[NSRefreshedObjectsKey] as? Set<NSManagedObject> ?? []
                
                if updated.contains(model) || refreshed.contains(model) {
                    handler(.updated)
                }
            })
        )
    }
}
