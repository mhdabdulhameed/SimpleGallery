//
//  ViewControllerType.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol ViewControllerType: class {
    associatedtype ViewModelType: ViewModelProtocol
    
    func configure(with viewModel: ViewModelType)
}

