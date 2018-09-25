//
//  ViewModelProtocol.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

/// All view models should implement this protocol.
protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
}

