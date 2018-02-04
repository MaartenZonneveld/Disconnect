//
//  ViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let autoDimmingController = AutoDimmingController()
    private let morningActivityController = MorningActivityController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.autoDimmingController.isSleepAllowed = true

        UIApplication.shared.isIdleTimerDisabled = true

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { _ in
            self.autoDimmingController.isSleepAllowed = false
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
            self.autoDimmingController.isSleepAllowed = true
        }

    }

    @objc
    private func viewTapped() {
        self.autoDimmingController.screenTapped()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

