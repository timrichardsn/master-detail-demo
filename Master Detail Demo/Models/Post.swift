//
//  Post.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import CoreData

final class Post:NSManagedObject {
    @NSManaged fileprivate(set) var postId:Int16
    @NSManaged fileprivate(set) var userId:Int16
    @NSManaged fileprivate(set) var title:String?
    @NSManaged fileprivate(set) var body:String?
}