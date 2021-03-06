//
//  APIConstants.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

extension Constants {
    
    /// All the constants used with API requests.
    struct APIConstants {
        
        /// The base URL of jsonplaceholder.typicode.com.
        static let baseURL = "https://jsonplaceholder.typicode.com/"
        
        static let albums = "albums"
        static let photos = "photos"
        
        static let albumId = "albumId"
        static let photoId = "id"
        
        private init() { }
    }
}
