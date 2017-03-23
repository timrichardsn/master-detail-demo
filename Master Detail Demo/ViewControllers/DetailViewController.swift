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
    @IBOutlet fileprivate weak var bodyLabel: UILabel!
    
    var viewModel:DetailViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }
}

// MARK: - Overrides
extension DetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func detailViewModelDelegate(didUpdateTitle title: String) {
        titleLabel.text = title
    }
    
    func detailViewModelDelegate(didUpdateBody body: String) {
        bodyLabel.text = body
    }
}
