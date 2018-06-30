//
//  OnboardingBulletins.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 17/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import BLTNBoard
import UIKit

internal final class OnboardingBulletins {

    static func notifications(action: @escaping (_ item: BLTNItem) -> Void) -> BLTNPageItem {
        let page = BLTNPageItem(title: "Notifications")
//        page.image = UIImage(named: "...")

        page.descriptionText = "Receive notifications when you use your device while you should be sleeping."
        page.actionButtonTitle = "Allow"
        page.alternativeButtonTitle = "Not now"
        page.isDismissable = false
        page.actionHandler = { item in
            action(item)
        }
        page.alternativeHandler = { item in
            item.manager?.displayNextItem()
        }
        return page
    }

    static func motion(action: @escaping (_ item: BLTNItem) -> Void) -> BLTNPageItem {
        let page = BLTNPageItem(title: "Motion")
        //        page.image = UIImage(named: "...")

        page.descriptionText = "The app uses Motion data to determine if you get out of bed. Without permission, the app will not work."
        page.actionButtonTitle = "Allow"
        page.alternativeButtonTitle = "Not now"
        page.isDismissable = false
        page.actionHandler = { item in
            action(item)
        }
        page.alternativeHandler = { item in
            item.manager?.displayNextItem()
        }
        return page
    }

    static func completed(action: @escaping (_ item: BLTNItem) -> Void) -> BLTNPageItem {
        let page = BLTNPageItem(title: "Setup Completed")
        //        page.image = UIImage(named: "...")

        page.descriptionText = "You are good to go."
        page.actionButtonTitle = "Get started"
        page.isDismissable = true
        page.requiresCloseButton = false
        page.actionHandler = { item in
            action(item)
        }
        return page
    }
}
