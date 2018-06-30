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

    static func appearance() -> BLTNItemAppearance {
        let appearance = BLTNItemAppearance()
        appearance.titleFontSize = 28
        appearance.descriptionFontSize = 17
        appearance.alternativeButtonFontSize = 13
        return appearance
    }

    static func notifications(action: @escaping (_ item: BLTNItem) -> Void) -> BLTNPageItem {
        let page = BLTNPageItem(title: "Notifications")
        page.appearance = self.appearance()
        //page.image = #imageLiteral(resourceName: "NotificationPrompt")
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
        page.appearance = self.appearance()
        page.descriptionText = "The app uses Motion data to determine if you get out of bed.\n\nNo cheating 😎"
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
        let page = BLTNPageItem(title: "That's it")
        page.appearance = self.appearance()
        page.descriptionText = "You are good to go 😴"
        page.actionButtonTitle = "Get started"
        page.isDismissable = true
        page.requiresCloseButton = false
        page.actionHandler = { item in
            action(item)
        }
        return page
    }
}
