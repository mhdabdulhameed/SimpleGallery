//
//  AlbumCollectionViewCell.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/23/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    /// `AlbumCollectionViewCell` reuse identifier.
    static let reuseIdentifier = String(describing: AlbumCollectionViewCell.self)
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var albumThumbnailImageView: UIImageView!
    
    // MARK: - Methods
    
    /// Configures a cell with view model.
    ///
    /// - Parameter albumViewModel: an instance of `AlbumViewModel` to configure the cell with.
    func configure(with albumViewModel: AlbumViewModel) {
        albumTitleLabel.text = albumViewModel.title
    }
}
