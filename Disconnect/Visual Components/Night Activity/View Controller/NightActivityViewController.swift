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

    private weak var autoScreenDimmingControllerAppWentToSleepObserver: AnyObject?

    private var hideStatusBar = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.setNeedsStatusBarAppearanceUpdate()
                self.view.layoutIfNeeded()
            }
        }
    }

    private var userLeftLockedAppSession: UserLeftLockedAppSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.userLeftLockedAppSession = UserLeftLockedAppSession()

        AppDelegate.shared.appLockController.isAppLocked = true

        AppDelegate.shared.autoScreenDimmingController.isSleepAllowed = true

        self.autoScreenDimmingControllerAppWentToSleepObserver = NotificationCenter.default.addObserver(forName: .AutoScreenDimmingControllerAppWentToSleep, object: nil, queue: nil) { [weak self] _ in
            self?.hideStatusBar = true
        }
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
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return self.hideStatusBar
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    @objc
    private func viewTapped() {
        self.hideStatusBar = !self.hideStatusBar
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
