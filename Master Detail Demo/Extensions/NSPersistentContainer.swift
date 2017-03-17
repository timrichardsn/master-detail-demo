//
//  NSPersistentContainer.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

extension NSPersistentContainer {
    class func setup(completion: @escaping (NSPersistentContainer) -> ()) {
        let container = NSPersistentContainer(name: "MasterDetail")
        container.loadPersistentStores { (_, error) in
            guard error == nil else { fatalError("Failed to load store: \(error)") }
            DispatchQueue.main.async {
                completion(container)
            }
        }
    }
}
