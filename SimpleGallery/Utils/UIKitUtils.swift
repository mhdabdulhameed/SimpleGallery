//
//  UIKitUtils.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class UIKitUtils {
    
    /// Returns whether the application is in Portrait mode or not.
    ///
    /// - Returns: A boolean value indicating whether the application is in Portrait mode or not.
    static func isPortrait() -> Bool {
        let orientation = UIApplication.shared.statusBarOrientation
        return orientation == .portrait || orientation == .portraitUpsideDown
    }
    
    /// Returns whether the current device has a wide screen or not.
    /// This method returns true for all iPad devices and for any device that is not in Portrait mode.
    ///
    /// - Returns: A boolean value indicating whether the device has a wide screen or not.
    static func isWideScreen() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad || !isPortrait()
    }
}
