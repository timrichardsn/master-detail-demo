//
//  User.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 21/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

final class User:NSManagedObject, ManagedModel {
    @NSManaged fileprivate(set) var userId:Int16
    @NSManaged fileprivate(set) var name:String?
    @NSManaged public fileprivate(set) var posts:Set<Post>?
    
    static func insertInto(managedObjectContext:NSManagedObjectContext, data:APIData) -> User {
        guard let userId = data["id"] as? Int16 else { fatalError("Incorrect API response") }
        
        let user:User = managedObjectContext.insertManaged()
        user.userId = userId
        user.name = data["name"] as? String
        return user
    }
    
    static func findOrCreate(userWithId:Int16, in context:NSManagedObjectContext) -> User {
        let predicate = NSPredicate(format: "%K == %d", #keyPath(userId), userWithId)
        let user = User.findOrCreate(in: context, matching: predicate) { _ in }
        return user
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(userId), ascending: false)]
    }
}
