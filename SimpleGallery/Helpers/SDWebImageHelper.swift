//
//  SDWebImageHelper.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import SDWebImage

/// A helper class that uses `SDWebImage` library to perform some operations.
class SDWebImageHelper {
    
    private init() { }
    
    
    /// Sets the image of a `UIImageView` from a `URL`.
    ///
    /// - Parameters:
    ///   - imageView: The `UIImageView` instance that we want to set its image.
    ///   - url: The URL of the image.
    ///   - completed: A completion handler to be called when the URL is downloaded and set in the image view.
    static func setImage(for imageView: UIImageView, from url: URL, completed: (() -> Void)? = nil) {
        imageView.sd_showActivityIndicatorView()
        imageView.sd_setImage(with: url) { _, _, _, _ in completed?() }
    }
}
