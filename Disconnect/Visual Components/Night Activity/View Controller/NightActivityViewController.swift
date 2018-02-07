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

    private var userLeftLockedAppNotificationObserver: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.userLeftLockedAppNotificationObserver = NotificationCenter.default.addObserver(forName: .UserLeftLockedAppNotification, object: nil, queue: nil) { _ in
            self.userLeftLockedApp()
        }
        AppDelegate.shared.appLockController.isAppLocked = true

        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let observer = self.userLeftLockedAppNotificationObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        AppDelegate.shared.appLockController.isAppLocked = false

        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = false
    }

    private func userLeftLockedApp() {
        let content = LocalNotificationController.shared.localNotificationContent(title: "Go back to sleep! 😴", body: "Tap here to go back.", subtitle: "You should not use your phone right now.", badge: 1)
        LocalNotificationController.shared.sendLocalNotification(identifier: "userLeftLockedApp", content: content)
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
