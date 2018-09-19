//
//  AlbumsViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RxSwift

final class AlbumsViewModel: ViewModelProtocol {
    
    // MARK: - ViewModelProtocol Conformance
    
    struct Input {
        /// Call to open an album.
        let selectAlbum: AnyObserver<AlbumViewModel>
        
        /// Call to reload albums.
        let reload: AnyObserver<Void>
    }
    
    struct Output {
        /// Emits an array of albums.
        let albums: Observable<[AlbumViewModel]>
        
        /// Emits an ID of an album to be shown.
        let showPhotos: Observable<Int>
        
        /// Emits an error to be shown.
        let errorsObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManager = MoyaNetworkManager.shared) {
        let selectAlbumSubject = PublishSubject<AlbumViewModel>()
        let reloadSubject = PublishSubject<Void>()
        let albumsSubject = PublishSubject<[AlbumViewModel]>()
        let errorsSubject = PublishSubject<Error>()
        
        input = Input(selectAlbum: selectAlbumSubject.asObserver(),
                      reload: reloadSubject.asObserver())
        output = Output(albums: albumsSubject.asObservable(),
                        showPhotos: selectAlbumSubject.asObservable().map { $0.id },
                        errorsObservable: errorsSubject.asObservable())
        
        let result: Observable<Result<[Album]>> = networkManager.startRequest(api: .albums)
        
        result.subscribe(onNext: { result in
            switch result {
            case .success(let albums):
                albumsSubject.onNext(albums.map(AlbumViewModel.init))
            case .failure(let error):
                errorsSubject.onNext(error)
            }
        })
        .disposed(by: disposeBag)
    }
}
