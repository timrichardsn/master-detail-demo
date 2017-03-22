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
    @IBOutlet weak var userName: UILabel!
    
    var viewModel:DetailViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }
}

// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func detailViewModelDelegate(didUpdateTitle title: String) {
        titleLabel.text = title
    }
    
    func detailViewModelDelegate(didUpdateUserName name: String) {
        userName.text = name
    }
}
