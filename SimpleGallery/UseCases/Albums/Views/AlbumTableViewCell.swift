//
//  AlbumTableViewCell.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: AlbumTableViewCell.self)
    
    // MARK: - IBOutlets

    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var albumThumbnailImageView: UIImageView!
    
    // MARK: - Methods
    
    func configure(with albumViewModel: AlbumViewModel) {
        albumTitleLabel.text = albumViewModel.title
    }
}
