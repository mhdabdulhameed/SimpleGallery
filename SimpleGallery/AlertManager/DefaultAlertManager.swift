//
//  DefaultAlertManager.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

/// A default implementation of the `AlertManager` that uses the native `UIAlertController`.
class DefaultAlertManager: AlertManager {
    
    static let shared = DefaultAlertManager()
    
    private init() { }
    
    func showAlert(title: String, message: String, buttons: [(title: String, action: () -> Void)]?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let buttons = buttons {
            for button in buttons {
                let action = UIAlertAction(title: button.title, style: .default) { _ in
                    button.action()
                }
                alert.addAction(action)
            }
        }
        
        UIApplication.topViewController()?.present(alert, animated: true)
    }
}
