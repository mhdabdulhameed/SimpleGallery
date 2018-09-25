//
//  PhotosCoordinator.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift

final class PhotosCoordinator: BaseCoordinator<Void> {
    
    private let albumId: Int
    private let albumTitle: String
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, albumId: Int, albumTitle: String) {
        self.navigationController = navigationController
        self.albumId = albumId
        self.albumTitle = albumTitle
    }
    
    override func start() -> Observable<Void> {
        
        // Create an instance of `PhotosViewModel` and an instane of `PhotosViewController` and inject the view model and alert manager in the view controller.
        
        let photosViewController = PhotosViewController()
        let viewModel = PhotosViewModel(albumId: albumId, albumTitle: albumTitle)
        photosViewController.viewModel = viewModel
        photosViewController.alertManager = DefaultAlertManager.shared
        
        navigationController.pushViewController(photosViewController, animated: true)
        
        // When showPhoto is triggered we should the next screen.
        
        viewModel.output.showPhoto
            .flatMapLatest { [showPhoto, navigationController] photo -> Observable<Void> in
                showPhoto(photo, navigationController)
        }
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    /// Navigates to photo details screen.
    ///
    /// - Parameters:
    ///   - photoViewModel: The view model of the photo to show.
    ///   - navigationController: The controller to display the photo on.
    /// - Returns: An Observable that returns the result of this navigation.
    private func showPhoto(by photoViewModel: PhotoViewModel, in navigationController: UINavigationController) -> Observable<Void> {
        let photoDetailsCoordinator = PhotoDetailsCoordinator(rootViewController: navigationController, photo: photoViewModel)
        return coordinate(to: photoDetailsCoordinator)
    }
}
