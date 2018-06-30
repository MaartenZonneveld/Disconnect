//
//  RootViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import BulletinBoard
import UIKit

internal final class RootViewController: UITabBarController {

    private var bulletinManager: BulletinManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //self.showOnboardingIfNeeded()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension RootViewController {
    // MARK: Onboarding

    private var isOnboardingCompleted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "RootViewController.isOnboardingCompleted")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "RootViewController.isOnboardingCompleted")
            UserDefaults.standard.synchronize()
        }
    }

    private func showOnboardingIfNeeded() {
        if self.isOnboardingCompleted {
            return
        }

        let notifications = OnboardingBulletins.notifications
        notifications.actionHandler = { item in
            LocalNotificationController.shared.requestAuthorization(completion: { _ in
                item.displayNextItem()
            })
        }

        let items = [
            OnboardingBulletins.notifications,
            OnboardingBulletins.motion,
            OnboardingBulletins.completed
        ]

        self.showBulletins(items)
        self.isOnboardingCompleted = true
    }

    func showBulletins(_ items: [BulletinItem]) {

        var i = 0
        items.forEach { item in
            i += 1
            item.nextItem = items.indices.contains(i) ? items[i] : nil
        }

        guard let root = items.first else {
            return
        }

        self.bulletinManager = BulletinManager(rootItem: root)
        self.bulletinManager?.backgroundViewStyle = .blurredDark

        self.bulletinManager?.prepare()
        self.bulletinManager?.presentBulletin(above: self)
    }
}
