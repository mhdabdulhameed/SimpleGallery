//
//  AlertManager.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol AlertManager {
    func showAlert(title: String, message: String)
    func showAlert(title: String, message: String, buttons: [(title: String, action: () -> Void)]?)
}

extension AlertManager {
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, buttons: nil)
    }
}
