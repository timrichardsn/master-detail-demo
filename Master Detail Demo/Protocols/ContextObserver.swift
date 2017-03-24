//
//  ContextObserver.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

protocol ContextObserver: class {
    var observers: [NSObjectProtocol] { get set }
}

extension ContextObserver {
    func addObserver(_ observer:NSObjectProtocol) {
        observers.append(observer)
    }
    
    func removeObservers() {
        observers.removeAll()
    }
}
