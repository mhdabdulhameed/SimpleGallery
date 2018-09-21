//
//  SDWebImageHelper.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import SDWebImage

class SDWebImageHelper {
    
    private init() { }
    
    static func setImage(for imageView: UIImageView, from url: URL, completed: (() -> Void)? = nil) {
        imageView.sd_showActivityIndicatorView()
        imageView.sd_setImage(with: url) { _, _, _, _ in completed?() }
    }
}
