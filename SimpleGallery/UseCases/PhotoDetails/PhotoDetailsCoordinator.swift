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
        
        // Create an instance of `PhotoDetailsViewModel` and an instane of `PhotoDetailsViewController` and inject the view model and alert manager in the view controller.
        
        let photoDetailsViewController = PhotoDetailsViewController()
        let photoDetailsViewModel = PhotoDetailsViewModel(photo: photo)
        photoDetailsViewController.viewModel = photoDetailsViewModel
        photoDetailsViewController.alertManager = DefaultAlertManager.shared
        
        rootViewController.present(photoDetailsViewController, animated: true)
        
        return Observable.just(())
    }
}
