//
//  NightActivityViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class NightActivityViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var clockLabel: UILabel!
    @IBOutlet private weak var finishSleepButton: UIButton!

    private weak var autoScreenDimmingControllerAppWentToSleepObserver: AnyObject?

    private var clockTimer: Timer?

    private var dimmed = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
            self.containerView.alpha = self.dimmed ? 0.0 : 1.0

            if self.dimmed {
                self.stopClockTimer()
            } else {
                self.startClockTimer()
            }
        }
    }

    private var userLeftLockedAppSession: UserLeftLockedAppSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.finishSleepButton.layer.cornerRadius = 10.0
        self.finishSleepButton.layer.borderColor = UIColor.white.cgColor
        self.finishSleepButton.layer.borderWidth = 1.0

        self.updateClock()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.userLeftLockedAppSession = UserLeftLockedAppSession()

        AppDelegate.shared.appLockController.isAppLocked = true

        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = true

        self.autoScreenDimmingControllerAppWentToSleepObserver = NotificationCenter.default.addObserver(forName: .AutoScreenDimmingControllerSleepChanged, object: nil, queue: nil) { [weak self] notification in
            self?.updateClock()
            let sleeping = notification.object as? Bool ?? false
            self?.dimmed = sleeping
        }

        self.startClockTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let observer = self.autoScreenDimmingControllerAppWentToSleepObserver {
            NotificationCenter.default.removeObserver(observer)
        }

        self.userLeftLockedAppSession?.destruct()
        self.userLeftLockedAppSession = nil

        AppDelegate.shared.appLockController.isAppLocked = false

        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = false

        self.stopClockTimer()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return self.dimmed
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
}

extension NightActivityViewController {
    // MARK: - Clock

    private func startClockTimer() {
        self.stopClockTimer()

        self.clockTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { [weak self] _ in
            self?.updateClock()
        })
        self.clockTimer?.tolerance = 5.0
    }

    private func stopClockTimer() {
        self.clockTimer?.invalidate()
    }

    private func updateClock() {
        self.clockLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
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
        self.show(activityViewController, sender: nil)
    }
}
