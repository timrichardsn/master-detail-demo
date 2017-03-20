//
//  API.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

enum API {
    case posts, users, albums, photos
}

extension API {
    var base:URL {
        return URL(string: "http://jsonplaceholder.typicode.com")!
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
}

extension API {
    func fetch() -> Result<String> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            
        }
        
        task.resume()
        
        return Result.success("")
    }
}
