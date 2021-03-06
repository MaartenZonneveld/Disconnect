//
//  AutoDimmingController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation
import UIKit.UIScreen

internal final class AutoDimmingController {

    private let dimDelay = 5.0

    private var restorationBrightness = UIScreen.main.brightness
    private weak var sleepTimer: Timer?

    var isSleepAllowed = false {
        didSet {
            if self.isSleepAllowed {
                self.temporaryWake()
            } else {
                self.wake()
            }
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

        self.sleepTimer = Timer.scheduledTimer(withTimeInterval: self.dimDelay, repeats: false, block: { _ in
            self.sleep()
        })
        self.sleepTimer?.tolerance = 2.5
    }

    private func sleep() {
        self.restorationBrightness = UIScreen.main.brightness
        UIScreen.main.wantsSoftwareDimming = true
        UIScreen.main.brightness = 0.0
    }

    func screenTapped() {
        self.temporaryWake()
    }
}
