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
        
//        viewModel.showRepository
//            .subscribe(onNext: { [weak self] in self?.showRepository(by: $0, in: navigationController) })
//            .disposed(by: disposeBag)
        
        viewModel.output.showPhotos
            .subscribe(onNext: { [weak self] id in
                self?.showPhoto(ofAlbum: id, in: navigationController)
            })
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    func showPhoto(ofAlbum id: Int, in navigationController: UINavigationController) {
        let photosViewController = PhotosViewController()
        let viewModel = PhotosViewModel()
        photosViewController.viewModel = viewModel
        navigationController.pushViewController(photosViewController, animated: true)
    }
}
