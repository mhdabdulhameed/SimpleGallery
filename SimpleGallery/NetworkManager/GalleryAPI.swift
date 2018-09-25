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
    case photos(albumId: Int)
    case photo(photoId: Int)
}

extension GalleryAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.APIConstants.baseURL) else { fatalError("Base URL couldn't be configured!") }
        return url
    }
    
    var path: String {
        switch self {
        case .albums:
            return Constants.APIConstants.albums
        case .photos, .photo:
            return Constants.APIConstants.photos
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .albums, .photos, .photo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .albums:
            return .requestPlain
        case .photos(let albumId):
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: JSONEncoding.default, urlParameters: [Constants.APIConstants.albumId: albumId])
        case .photo(let photoId):
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: JSONEncoding.default, urlParameters: [Constants.APIConstants.photoId: photoId])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .albums, .photos, .photo:
            return nil
        }
    }
}
