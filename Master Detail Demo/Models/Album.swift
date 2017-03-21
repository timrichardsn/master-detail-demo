//
//  Album.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 21/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

final class Album:NSManagedObject, ManagedModel {
    @NSManaged fileprivate(set) var albumId:Int16
    @NSManaged fileprivate(set) var userId:Int16
    @NSManaged fileprivate(set) var title:String?
    @NSManaged public fileprivate(set) var user:User
    
    static func findOrCreate(withData data:APIData, in context:NSManagedObjectContext) -> Album {
        guard let id = data["id"] as? Int16, let userId = data["userId"] as? Int16 else { fatalError("Incorrect API response") }
        
        let predicate = NSPredicate(format: "%K == %d", #keyPath(albumId), id)
        let album = Album.findOrCreate(in: context, matching: predicate) { (album) in
            album.albumId = id
            album.userId = userId
            album.title = data["title"] as? String
            album.user = User.findOrCreate(withId: userId, in: context)
        }
        
        return album
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(albumId), ascending: false)]
    }
}
