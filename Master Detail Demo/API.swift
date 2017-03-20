//
//  API.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

typealias PostsFetchResult = [PostData]

enum API {
    case posts, users, albums, photos
}

extension API {
    var base:URL {
        // consider extracting further into it's own enum "Endpoint" ?
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else { fatalError("Invalid url") }
        return url
    }
    
    var path:String {
        switch self {
        case .posts: return "/posts"
        case .users: return "/users"
        case .albums: return "/albums"
        case .photos: return "/photos"
        }
    }
    
    var url:URL {
        return base.appendingPathComponent(path)
    }
    
    var httpMethod:String {
        switch self {
        default: return "GET"
        }
    }
}

extension API {
    func fetch(completion: @escaping (Result<PostsFetchResult>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.execute(completion: completion)
    }
}
