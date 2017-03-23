//
//  AlbumTableViewCell.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    func configure(with album:Album) {
        textLabel?.text = album.title
    }
}
