//
//  Album.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String
    
    private enum CodingKeys: CodingKey, String {
        case userId
        case id
        case title
    }
}
