//
//  RootViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import BLTNBoard
import UIKit

internal final class RootViewController: UITabBarController {

    private var bulletinItemManager: BLTNItemManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBar.tintColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showOnboardingIfNeeded()
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

        let notifications = OnboardingBulletins.notifications(action: { item in
            LocalNotificationController.shared.requestAuthorization(completion: { _ in
                DispatchQueue.main.async {
                    item.manager?.displayNextItem()
                }
            })
        })

        let motion = OnboardingBulletins.motion { item in

            MotionActivityProvider.requestPermission {
                DispatchQueue.main.async {
                    item.manager?.displayNextItem()
                }
            }
        }

        let completed = OnboardingBulletins.completed { item in
            item.manager?.dismissBulletin()
        }

        self.showBulletins([
            notifications,
            motion,
            completed
            ])
        self.isOnboardingCompleted = true
    }

    func showBulletins(_ items: [BLTNItem]) {

        var i = 0
        items.forEach { item in
            i += 1
            item.next = items.indices.contains(i) ? items[i] : nil
        }

        guard let root = items.first else {
            return
        }

        self.bulletinItemManager = BLTNItemManager(rootItem: root)
        self.bulletinItemManager?.backgroundViewStyle = .blurredDark

        self.bulletinItemManager?.showBulletin(above: self)
    }
}
