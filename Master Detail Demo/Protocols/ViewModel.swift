//
//  ViewModel.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype T
    associatedtype A
    var delegate:T? { get set }
    func configure(with:A)
}
