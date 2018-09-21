//
//  PhotoCollectionViewCell.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: PhotoCollectionViewCell.self)
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    // MARK: - Methods
    
    func configure(with photoViewModel: PhotoViewModel) {
        SDWebImageHelper.setImage(for: thumbnailImageView, from: photoViewModel.url) { [weak self] in
            self?.thumbnailImageView.alpha = 0
            UIView.animate(withDuration: 1.0) {
                self?.thumbnailImageView.alpha = 1
            }
        }
    }
}
