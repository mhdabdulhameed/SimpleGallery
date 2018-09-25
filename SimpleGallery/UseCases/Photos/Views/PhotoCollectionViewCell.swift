//
//  PhotoCollectionViewCell.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    /// `PhotoCollectionViewCell` reuse identifier.
    static let reuseIdentifier = String(describing: PhotoCollectionViewCell.self)
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    // MARK: - Methods
    
    /// Configures a cell with view model.
    ///
    /// - Parameter photoViewModel: an instance of `PhotoViewModel` to configure the cell with.
    func configure(with photoViewModel: PhotoViewModel) {
        
        // Set the thumbnail image from remote URL and animte its display.
        SDWebImageHelper.setImage(for: thumbnailImageView, from: photoViewModel.url) { [weak self] in
            self?.thumbnailImageView.alpha = 0
            UIView.animate(withDuration: 0.2) {
                self?.thumbnailImageView.alpha = 1
            }
        }
    }
}
