//
//  MoyaNetworkManager.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya
import RxSwift

/// An implementation of `Network Manager` that uses `Moya` to make API requests.
class MoyaNetworkManager: NetworkManager {
    
    static let shared = MoyaNetworkManager()
    
    private lazy var provider: MoyaProvider<GalleryAPI> = {
        return MoyaProvider<GalleryAPI>(plugins: plugins)
    }()
    
    private lazy var plugins: [PluginType] = {
        return [/*NetworkLoggerPlugin(verbose: true)*/]
    }()
    
    private init() { }
    
    func startRequest<T: Codable>(api: GalleryAPI) -> Observable<Result<T>> {
        return provider.rx.request(api)
            .map(T.self)
            .asObservable()
            .map(Result.success)
            .catchError({ error -> Observable<Result<T>> in
                return .just(Result.failure(error))
            })
    }
}
