//
//  URLRequest.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

extension URLRequest {
    func execute<T>(completion: @escaping (Result<T>) -> ()) {
        
        let task = URLSession.shared.dataTask(with: self) { (data, _, error) in
            
            if let error = error {
                completion(Result.failure(error: error))
                return
            }
            
            guard let d = data, let json = try? JSONSerialization.jsonObject(with: d, options: []), let result = json as? T else {
                // TODO: full error handling should be correctly processed in production
                completion(Result.failure(error: NSError(domain: "local", code: 0, userInfo: [NSLocalizedDescriptionKey:""])))
                return
            }
            
            completion(Result.success(result))
        }
        
        task.resume()
    }
}
