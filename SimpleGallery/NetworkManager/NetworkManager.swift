//
//  NetworkManager.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RxSwift

protocol NetworkManager {
    
    /// Starts a network request with the specified API End Point.
    ///
    /// - Parameter api: the End Point to call.
    /// - Returns: An `Observable` of type `Result<T>`.
    func startRequest<T: Codable>(api: GalleryAPI) -> Observable<Result<T>>
}
