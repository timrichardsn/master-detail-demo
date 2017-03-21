//
//  Post.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

final class Post:NSManagedObject, ManagedModel {
    @NSManaged fileprivate(set) var postId:Int16
    @NSManaged fileprivate(set) var userId:Int16
    @NSManaged fileprivate(set) var title:String?
    @NSManaged fileprivate(set) var body:String?
    @NSManaged public fileprivate(set) var user:User
    
    static func insertInto(managedObjectContext:NSManagedObjectContext, data:APIData) -> Post {
        guard let postId = data["id"] as? Int16, let userId = data["userId"] as? Int16 else { fatalError("Incorrect API response") }
        
        let post:Post = managedObjectContext.insertManaged()
        post.postId = postId
        post.userId = userId
        post.title = data["title"] as? String
        post.body = data["body"] as? String
        post.user = User.findOrCreate(userWithId: userId, in: managedObjectContext)
        
        return post
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(postId), ascending: false)]
    }
}
