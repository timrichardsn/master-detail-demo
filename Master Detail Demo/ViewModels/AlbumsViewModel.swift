//
//  AlbumsViewModel.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import Foundation

protocol AlbumsViewModelDelegate {
    func albumsViewModel(albumsViewModel:AlbumsViewModel, showAlbumsByUser userId:Int16)
}

class AlbumsViewModel: ViewModel {
    typealias T = AlbumsViewModelDelegate
    typealias A = Post
    
    var delegate:AlbumsViewModelDelegate?
    
    func configure(with post: Post) {
        delegate?.albumsViewModel(albumsViewModel: self, showAlbumsByUser: post.user.userId)
    }
}
