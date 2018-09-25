//
//  AlertManager.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol AlertManager {
    
    /// Shows an alert to the user.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The body of the alert.
    func showAlert(title: String, message: String)
    
    /// Shows an alert to the user.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The body of the alert.
    ///   - buttons: An array of tuples, each tuple consists of a title of a button and the action of that button.
    func showAlert(title: String, message: String, buttons: [(title: String, action: () -> Void)]?)
}

extension AlertManager {
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, buttons: nil)
    }
}
