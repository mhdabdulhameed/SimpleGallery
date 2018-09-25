//
//  AppCoordinator.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        // Create an instance of `AlbumsCoordinator` and coordinate to it.
        let albumsCoordinator = AlbumsCoordinator(window: window)
        return coordinate(to: albumsCoordinator)
    }
}
