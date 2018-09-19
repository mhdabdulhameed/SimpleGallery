//
//  AlbumViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

struct AlbumViewModel {
    let id: Int
    let title: String
    
    init(album: Album) {
        id = album.id
        title = album.title
    }
}
