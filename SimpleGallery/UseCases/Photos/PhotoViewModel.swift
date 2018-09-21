//
//  PhotoViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

struct PhotoViewModel {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init(photo: Photo) {
        id = photo.id
        title = photo.title
        url = photo.url
        thumbnailUrl = photo.thumbnailUrl
    }
}

