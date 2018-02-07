//
//  AppLockController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 06/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation
import UIKit.UIApplication

internal extension Notification.Name {

    static let UserLeftLockedAppNotification = Notification.Name(rawValue: "UserLeftLockedAppNotification")
}

internal final class AppLockController {

    var isAppLocked = false {
        didSet {
            UIApplication.shared.isIdleTimerDisabled = self.isAppLocked
            self.notifiyUserIfNeeded()

            self.removeObservers()

            if self.isAppLocked {
                self.addObservers()
            }
        }
    }

    private(set) var isAppActive = true {
        didSet {
            self.notifiyUserIfNeeded()
        }
    }

    private var UIApplicationDidBecomeActiveObserver: Any?
    private var UIApplicationWillResignActiveObserver: Any?

    private func addObservers() {

        self.UIApplicationDidBecomeActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
            self.isAppActive = true
        }
        self.UIApplicationWillResignActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { _ in
            self.isAppActive = false
        }
    }

    private func removeObservers() {
        if let observer = self.UIApplicationDidBecomeActiveObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = self.UIApplicationWillResignActiveObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    private func notifiyUserIfNeeded() {
        if !self.isAppActive && self.isAppLocked {
            NotificationCenter.default.post(name: .UserLeftLockedAppNotification, object: nil)
        }
    }
}
