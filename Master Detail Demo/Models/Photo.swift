//
//  Photo.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 21/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

final class Photo:NSManagedObject, ManagedModel {
    @NSManaged fileprivate(set) var albumId:Int16
    @NSManaged fileprivate(set) var photoId:Int16
    @NSManaged fileprivate(set) var title:String?
    @NSManaged fileprivate(set) var url:String?
    @NSManaged fileprivate(set) var thumbnailUrl:String?
    @NSManaged public fileprivate(set) var album:Album
    
    static func findOrCreate(withData data:APIData, in context:NSManagedObjectContext) -> Photo {
        guard let id = data["id"] as? Int16, let albumId = data["albumId"] as? Int16 else { fatalError("Incorrect API response") }
        
        let predicate = NSPredicate(format: "%K == %d", #keyPath(photoId), id)
        let photo = Photo.findOrCreate(in: context, matching: predicate) { (photo) in
            photo.photoId = id
            photo.albumId = albumId
            photo.title = data["title"] as? String
            photo.url = data["url"] as? String
            photo.thumbnailUrl = data["thumbnailUrl"] as? String
            photo.album = Album.findOrCreate(withId: albumId, in: context)
        }
        
        return photo
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(photoId), ascending: false)]
    }
}
