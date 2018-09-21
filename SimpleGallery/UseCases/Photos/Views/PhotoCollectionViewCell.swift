//
//  PhotoCollectionViewCell.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: AlbumTableViewCell.self)
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    // MARK: - Methods
    
    func configure(with photoViewModel: PhotoViewModel) {
//        photoViewModel.thumbnailUrl
    }
}
