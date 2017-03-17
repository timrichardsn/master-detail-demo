//
//  NSManagedObjectContext.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    // generic A is a subtype of NSManagedObject and conforms to ManagedModel
    func insertManaged<A:NSManagedObject>() -> A where A:ManagedModel {
        guard let managedModel = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Trying to insert object with incorrect type") }
        return managedModel
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    func execute(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
}
