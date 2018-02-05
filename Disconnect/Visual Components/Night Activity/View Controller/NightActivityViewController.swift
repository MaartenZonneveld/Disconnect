//
//  NightActivityViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class NightActivityViewController: UIViewController {

    @IBOutlet private weak var finishSleepButton: UIButton!

    private var isViewAppeared = false {
        didSet {
            AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = self.isViewAppeared && self.isAppActive
        }
    }
    private var isAppActive = true {
        didSet {
            AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = self.isViewAppeared && self.isAppActive
        }
    }

    private var UIApplicationDidBecomeActiveObserver: Any?
    private var UIApplicationWillResignActiveObserver: Any?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.UIApplicationDidBecomeActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
            self.isAppActive = true
        }
        self.UIApplicationWillResignActiveObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { _ in
            self.isAppActive = false
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isViewAppeared = true
        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isViewAppeared = false
        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

internal extension NightActivityViewController {
    // MARK: UI Actions

    @IBAction private func finishSleepButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
