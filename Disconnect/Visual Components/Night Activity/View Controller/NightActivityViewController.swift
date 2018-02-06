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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppDelegate.shared.appLockController.isAppLocked = true
        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.shared.appLockController.isAppLocked = false
        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

internal extension NightActivityViewController {
    // MARK: UI Actions

    @IBAction private func finishSleepButtonPressed(_ sender: Any) {
        let activityViewController: MorningActivityViewController
        do {
            activityViewController = try MorningActivity.factory(for: MorningActivityViewController.self).initialViewController()
        } catch {
            fatalError(error.localizedDescription)
        }
        AppDelegate.shared.appWindow.rootViewController().presentRoot(activityViewController, animated: true, completion: nil)
    }
}
