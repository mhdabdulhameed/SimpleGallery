//
//  NetworkManager.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RxSwift

protocol NetworkManager {
    func startRequest<T: Codable>(api: GalleryAPI) -> Observable<Result<T>>
}
