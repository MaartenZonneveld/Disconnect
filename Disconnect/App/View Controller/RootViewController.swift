//
//  RootViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class RootViewController: UIViewController {

    private let morningActivityController = MorningActivityController()

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true

//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { _ in
//            self.autoDimmingController.isSleepAllowed = false
//        }
//
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
//            self.autoDimmingController.isSleepAllowed = true
//        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
