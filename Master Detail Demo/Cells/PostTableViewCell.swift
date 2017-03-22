//
//  PostTableViewCell.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 20/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var postTitle: UILabel!
    @IBOutlet fileprivate weak var postUser: UILabel!
    
    func configure(withPost post:Post) {
        postTitle.text = post.title ?? ""
        postUser.text = post.user.name ?? ""
    }
}
