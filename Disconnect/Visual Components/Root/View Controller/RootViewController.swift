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

        self.showBulletins([OnboardingBulletins.notifications, OnboardingBulletins.motion, OnboardingBulletins.completed])
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
