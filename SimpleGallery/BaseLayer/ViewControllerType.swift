//
//  ViewControllerType.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

/// All view controllers should implement this protocol.
protocol ViewControllerType: class {
    
    associatedtype ViewModelType: ViewModelProtocol
    
    /// Configures a view controller with a view model.
    ///
    /// - Parameter viewModel: the view model to configure the view controller with.
    func configure(with viewModel: ViewModelType)
}

