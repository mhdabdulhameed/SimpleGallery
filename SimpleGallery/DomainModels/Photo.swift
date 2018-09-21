//
//  Photo.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    private enum CodingKeys: CodingKey, String {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
