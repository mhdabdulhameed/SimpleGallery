//
//  GalleryAPI.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya

enum GalleryAPI {
    case albums
    case photos(albumID: Int)
}

extension GalleryAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.APIConstants.baseURL) else { fatalError("Base URL couldn't be configured!") }
        return url
    }
    
    var path: String {
        switch self {
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .albums, .photos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .albums, .photos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .albums, .photos:
            return nil
        }
    }
}
