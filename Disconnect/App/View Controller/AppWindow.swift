//
//  AppWindow.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal extension NSNotification.Name {

    static let AppWindowTapped = NSNotification.Name(rawValue: "AppWindowTapped")
}

internal final class AppWindow: UIWindow {

    func setup() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(windowTapped)))
    }

    @objc
    private func windowTapped() {
        NotificationCenter.default.post(name: .AppWindowTapped, object: nil)
    }
}
