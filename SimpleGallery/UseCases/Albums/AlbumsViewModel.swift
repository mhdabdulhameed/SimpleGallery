//
//  AlbumsViewModel.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

final class AlbumsViewModel: ViewModelProtocol {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let input: Input
    let output: Output
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        input = Input()
        output = Output()
        self.networkManager = networkManager
    }
}
