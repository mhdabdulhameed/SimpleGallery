//
//  PhotoViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

struct PhotoViewModel {
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    init(photo: Photo) {
        id = photo.id
        title = photo.title
        url = URL(string: photo.url)!
        thumbnailUrl = URL(string: photo.thumbnailUrl)!
    }
}

