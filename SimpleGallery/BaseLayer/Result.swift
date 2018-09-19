//
//  Result.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}
