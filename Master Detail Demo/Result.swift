//
//  Result.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(error:Error)
}
