//
//  OnboardingBulletins.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 17/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import BulletinBoard
import UIKit

internal final class OnboardingBulletins {

    static var notifications: PageBulletinItem {
        let page = PageBulletinItem(title: "Notifications")
//        page.image = UIImage(named: "...")

        page.descriptionText = "Receive notifications when you use your device while you should be sleeping."
        page.actionButtonTitle = "Allow"
        page.alternativeButtonTitle = "Not now"
        page.actionHandler = { item in
            item.displayNextItem()
        }
        return page
    }

    static var motion: PageBulletinItem {
        let page = PageBulletinItem(title: "Motion")
        //        page.image = UIImage(named: "...")

        page.descriptionText = "The app uses Motion data to determine if you get out of bed. Without permission, the app will not work."
        page.actionButtonTitle = "Allow"
        page.alternativeButtonTitle = "Not now"
        page.actionHandler = { item in
            item.displayNextItem()
        }
        return page
    }

    static var completed: PageBulletinItem {
        let page = PageBulletinItem(title: "Setup Completed")
        //        page.image = UIImage(named: "...")

        page.descriptionText = "You are good to go."
        page.actionButtonTitle = "Get started"
        page.isDismissable = true
        page.actionHandler = { item in
            item.manager?.dismissBulletin()
        }
        return page
    }
}
