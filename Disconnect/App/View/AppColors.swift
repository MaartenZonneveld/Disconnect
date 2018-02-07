//
//  AppColors.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 07/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit.UIColor

internal extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

internal extension UIColor {

    static let primaryTintColor = UIColor(r: 246.0, g: 250.0, b: 250.0)

    static let darkContentTintColor = UIColor.black

    static let eveningDarkBackgroundColor = UIColor(r: 2.0, g: 21.0, b: 44.0)
    static let eveningLightBackgroundColor = UIColor(r: 90.0, g: 77.0, b: 48.0)
}
