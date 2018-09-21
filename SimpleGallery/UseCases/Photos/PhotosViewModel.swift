//
//  PhotosViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RxSwift

final class PhotosViewModel: ViewModelProtocol {
    
    // MARK: - ViewModelProtocol Conformance
    
    struct Input {
        // Call to tell the view model that the view controller has been loaded.
        let viewDidLoad: AnyObserver<Void>
        
        /// Call to open an photo.
        let selectPhoto: AnyObserver<PhotoViewModel>
        
        /// Call to reload photos.
        let reload: AnyObserver<Void>
    }
    
    struct Output {
        /// Emits an array of photos.
        var photos: Observable<[PhotoViewModel]>
        
        /// Emits an ID of an album to be shown.
        let showPhoto: Observable<Int>
        
        /// Emits an error to be shown.
        let errorsObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let albumId: Int
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(albumId: Int, networkManager: NetworkManager = MoyaNetworkManager.shared) {
        self.albumId = albumId
        let viewDidLoadSubject = PublishSubject<Void>()
        let selectPhotoSubject = PublishSubject<PhotoViewModel>()
        let reloadSubject = PublishSubject<Void>()
        let photosSubject = PublishSubject<[PhotoViewModel]>()
        let errorsSubject = PublishSubject<Error>()
        
        // Initialize Input and Output of the view model.
        
        input = Input(viewDidLoad: viewDidLoadSubject.asObserver(),
                      selectPhoto: selectPhotoSubject.asObserver(),
                      reload: reloadSubject.asObserver())
        
        output = Output(photos: photosSubject.asObservable(),
                        showPhoto: selectPhotoSubject.asObservable().map { $0.id },
                        errorsObservable: errorsSubject.asObservable())
        
        // Merge viewDidLoad and reload, because we want the collection view to be loaded whenever one of them emits.
        
        Observable.merge([viewDidLoadSubject, reloadSubject])
            .flatMapLatest { [albumId] _ -> Observable<Result<[Photo]>> in
                networkManager.startRequest(api: .photos(albumId: albumId))
            }
            .subscribe(onNext: { result in
                switch result {
                case .success(let photos):
                    photosSubject.onNext(photos.map(PhotoViewModel.init))
                case .failure(let error):
                    errorsSubject.onNext(error)
                }
            })
            .disposed(by: disposeBag)
    }
}
