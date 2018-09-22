//
//  PhotoDetailsViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RxSwift

final class PhotoDetailsViewModel: ViewModelProtocol {
    
    // MARK: - ViewModelProtocol Conformance
    
    struct Input {
        
    }
    
    struct Output {
        /// Emits the title of the photo.
        var title: Observable<String>
        
        // Emits the id of the photo.
        var photoId: Observable<String>
        
        /// Emits the URL of the photo.
        var photoUrl: Observable<URL>
        
        /// Emits an error to be shown.
        let errorsObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let photo: PhotoViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManager = MoyaNetworkManager.shared, photo: PhotoViewModel) {
        self.photo = photo
        let titleSubject = BehaviorSubject<String>(value: photo.title)
        let photoIdSubject = BehaviorSubject<String>(value: String(photo.id))
        let photoUrlSubject = BehaviorSubject<URL>(value: photo.url)
        let errorsSubject = PublishSubject<Error>()
        
        // Initialize Input and Output of the view model.
        
        input = Input()
        
        output = Output(title: titleSubject.asObservable(),
                        photoId: photoIdSubject.asObservable(),
                        photoUrl: photoUrlSubject.asObservable(),
                        errorsObservable: errorsSubject.asObservable())
    }
}
