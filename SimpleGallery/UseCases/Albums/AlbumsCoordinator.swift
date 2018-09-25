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
        
        // Create an instance of `AlbumsViewModel` and an instane of `AlbumsViewController` and inject the view model and alert manager in the view controller.
        
        let viewModel = AlbumsViewModel()
        let viewController = AlbumsViewController()
        viewController.viewModel = viewModel
        viewController.alertManager = DefaultAlertManager.shared
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // When showPhotos is triggered we should the next screen.
        
        viewModel.output.showPhotos
            .flatMapLatest { [weak self, navigationController] album -> Observable<Void> in
                guard let strongSelf = self else { return .empty() }
                return strongSelf.showPhotos(of: album.albumId, and: album.albumTitle, in: navigationController)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    /// Navigates to the photos screen.
    ///
    /// - Parameters:
    ///   - albumId: The ID of the album we want to show its photos.
    ///   - albumTitle: The title of the album we want to show its photos.
    ///   - navigationController: The navigation controller to push the new controller to.
    /// - Returns: An Observable that returns the result of this navigation. In this case it's an Observable of Void because we don't we want to get any value from photos screen.
    func showPhotos(of albumId: Int, and albumTitle: String, in navigationController: UINavigationController) -> Observable<Void> {
        let photosCoordinator = PhotosCoordinator(navigationController: navigationController, albumId: albumId, albumTitle: albumTitle)
        return coordinate(to: photosCoordinator)
    }
}
