//
//  User.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 21/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

final class User:NSManagedObject {
    @NSManaged fileprivate(set) var userId:Int16
    @NSManaged fileprivate(set) var name:String?
    @NSManaged public fileprivate(set) var posts:Set<Post>?
    @NSManaged public fileprivate(set) var albums:Set<Album>?
}

// MARK: - ManagedModel
extension User: ManagedModel {
    static func findOrCreate(withData data:APIData, in context:NSManagedObjectContext) -> User {
        guard let id = data["id"] as? Int16 else { fatalError("Incorrect API response") }
        
        let user = findOrCreate(withId: id, in: context)
        user.name = data["name"] as? String
        return user
    }
    
    static func findOrCreate(withId id:Int16, in context:NSManagedObjectContext) -> User {
        let predicate = NSPredicate(format: "%K == %d", #keyPath(userId), id)
        let user = User.findOrCreate(in: context, matching: predicate) { user in
            user.userId = id
        }
        return user
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(userId), ascending: false)]
    }
}

extension User {
    var mutableAlbumsSet:NSMutableSet {
        return mutableSetValue(forKey: #keyPath(albums))
    }
}
