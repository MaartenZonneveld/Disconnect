//
//  AutoScreenDimmingControlle.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation
import UIKit.UIScreen

internal final class AutoScreenDimmingController {

    private let sleepDelay = 5.0

    private var restorationBrightness = UIScreen.main.brightness
    private weak var sleepTimer: Timer?

    var isSleepAllowed = false {
        didSet {
            UIDevice.current.isProximityMonitoringEnabled = self.isSleepAllowed

            self.removeSleepObservers()

            if self.isSleepAllowed {
                self.addSleepObservers()
                self.temporaryWake()
            } else {
                self.wake()
            }
        }
    }

    private var appWindowTappedObserver: Any?
    private var UIApplicationDidBecomeActiveObserver: Any?
    private var UIApplicationWillResignActiveObserver: Any?

    private func addSleepObservers() {

        self.appWindowTappedObserver = NotificationCenter.default.addObserver(forName: .AppWindowTapped, object: nil, queue: nil) { _ in
            self.temporaryWake()
        }
        self.UIApplicationDidBecomeActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
            self.temporaryWake()
        }
        self.UIApplicationWillResignActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { _ in
            self.wake()
        }
    }

    private func removeSleepObservers() {
        if let observer = self.appWindowTappedObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = self.UIApplicationDidBecomeActiveObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = self.UIApplicationWillResignActiveObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    private func wake() {
        self.sleepTimer?.invalidate()

        // Only restore brightness when it's 0.0. Other values indicate the user must have changed it:
        if UIScreen.main.brightness == 0.0 {
            UIScreen.main.brightness = self.restorationBrightness
        }
        UIScreen.main.wantsSoftwareDimming = false
    }

    private func temporaryWake() {
        self.wake()

        self.sleepTimer = Timer.scheduledTimer(withTimeInterval: self.sleepDelay, repeats: false, block: { _ in
            self.sleep()
        })
        self.sleepTimer?.tolerance = 2.5
    }

    private func sleep() {
        self.restorationBrightness = UIScreen.main.brightness
        UIScreen.main.wantsSoftwareDimming = true
        UIScreen.main.brightness = 0.0
    }
}
