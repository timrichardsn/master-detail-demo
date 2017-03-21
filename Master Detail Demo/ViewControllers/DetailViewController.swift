//
//  DetailViewController.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 21/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
}

extension DetailViewController {
    func configure(post:Post) {
        titleLabel.text = post.title
    }
}
