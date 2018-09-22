//
//  UIKitUtils.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class UIKitUtils {
    static func isPortrait() -> Bool {
        let orientation = UIApplication.shared.statusBarOrientation
        return orientation == .portrait || orientation == .portraitUpsideDown
    }
}
