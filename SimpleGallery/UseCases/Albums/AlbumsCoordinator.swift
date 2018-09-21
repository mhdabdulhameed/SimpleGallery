//
//  AlbumsCoordinator.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift

final class AlbumsCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = AlbumsViewModel()
        let viewController = AlbumsViewController()
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewModel.output.showPhotos
            .flatMapLatest { [weak self, navigationController]id -> Observable<Void> in
                guard let strongSelf = self else { return .empty() }
                return strongSelf.showPhoto(ofAlbum: id, in: navigationController)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    func showPhoto(ofAlbum id: Int, in navigationController: UINavigationController) -> Observable<Void> {
        let photosCoordinator = PhotosCoordinator(navigationController: navigationController, albumId: id)
        return coordinate(to: photosCoordinator)
    }
}
