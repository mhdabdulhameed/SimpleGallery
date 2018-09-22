//
//  PhotoDetailsCoordinator.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift

final class PhotoDetailsCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    private let photo: PhotoViewModel
    
    init(rootViewController: UIViewController, photo: PhotoViewModel) {
        self.rootViewController = rootViewController
        self.photo = photo
    }
    
    override func start() -> Observable<Void> {
        let photoDetailsViewController = PhotoDetailsViewController()
        let navigationController = UINavigationController(rootViewController: photoDetailsViewController)
        let photoDetailsViewModel = PhotoDetailsViewModel(photo: photo)
        photoDetailsViewController.viewModel = photoDetailsViewModel
        rootViewController.present(navigationController, animated: true)
        return Observable.just(())
    }
}
