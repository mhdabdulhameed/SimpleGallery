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
        let photosViewController = PhotosViewController()
        let viewModel = PhotosViewModel(albumId: albumId, albumTitle: albumTitle)
        photosViewController.viewModel = viewModel
        navigationController.pushViewController(photosViewController, animated: true)
        return Observable.just(())
    }
}
