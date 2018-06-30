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

extension UIWindow {

    static weak var windowTapGesture: UITapGestureRecognizer?

    func setupAppWindow() {
        self.rootViewController = UIStoryboard(name: "Root", bundle: nil).instantiateInitialViewController()

        let windowTapGesture = UITapGestureRecognizer()
        windowTapGesture.delegate = self
        self.addGestureRecognizer(windowTapGesture)
        UIWindow.windowTapGesture = windowTapGesture
    }

    func rootViewController() -> RootViewController {
        guard let root = (self.rootViewController as? UINavigationController)?.viewControllers.first as? RootViewController else {
            fatalError("rootViewController is not of type `RootViewController`")
        }
        return root
    }
}

extension UIWindow: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer === UIWindow.windowTapGesture {
            NotificationCenter.default.post(name: NSNotification.Name.AppWindowTapped, object: nil)
            return false
        }

        return true
    }
}
