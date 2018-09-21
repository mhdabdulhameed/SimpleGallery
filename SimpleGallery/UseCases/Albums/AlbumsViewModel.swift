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
        // Call to tell the view model that the view controller has been loaded.
        let viewDidLoad: AnyObserver<Void>
        
        /// Call to open an album.
        let selectAlbum: AnyObserver<AlbumViewModel>
        
        /// Call to reload albums.
        let reload: AnyObserver<Void>
    }
    
    struct Output {
        /// Emits an array of albums.
        var albums: Observable<[AlbumViewModel]>
        
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
        let viewDidLoadSubject = PublishSubject<Void>()
        let selectAlbumSubject = PublishSubject<AlbumViewModel>()
        let reloadSubject = PublishSubject<Void>()
        let albumsSubject = PublishSubject<[AlbumViewModel]>()
        let errorsSubject = PublishSubject<Error>()
        
        // Initialize Input and Output of the view model.
        
        input = Input(viewDidLoad: viewDidLoadSubject.asObserver(),
                      selectAlbum: selectAlbumSubject.asObserver(),
                      reload: reloadSubject.asObserver())
        
        output = Output(albums: albumsSubject.asObservable(),
                        showPhotos: selectAlbumSubject.asObservable().map { $0.id },
                        errorsObservable: errorsSubject.asObservable())
        
        // Merge viewDidLoad and reload, because we want the table view to be loaded whenever one of them emits.

        Observable.merge([viewDidLoadSubject, reloadSubject])
            .flatMapLatest { _ -> Observable<Result<[Album]>> in
                networkManager.startRequest(api: .albums)
            }
            .subscribe(onNext: { result in
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
