//
//  DetailViewModel.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 22/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: class {
    func detailViewModelDelegate(didUpdateTitle title:String)
    func detailViewModelDelegate(didUpdateBody body:String)
}

class DetailViewModel: ViewModel {
    typealias T = DetailViewModelDelegate
    typealias A = Post
    weak var delegate:DetailViewModelDelegate?
    
    func configure(with post:Post) {
        delegate?.detailViewModelDelegate(didUpdateTitle: post.title ?? "")
        delegate?.detailViewModelDelegate(didUpdateBody: post.body ?? "")
    }
}
