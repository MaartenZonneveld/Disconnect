//
//  UserLeftLockedAppSession.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 07/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation

internal final class UserLeftLockedAppSession {

    let localNotificationIdentifier = "userLeftLockedAppNotification"

    private var userLeftLockedAppNotificationObserver: Any?
    private var userReturnedToAppNotificationObserver: Any?

    init() {
        self.userLeftLockedAppNotificationObserver = NotificationCenter.default.addObserver(forName: .UserLeftLockedAppNotification, object: nil, queue: nil) { _ in
            self.userLeftLockedApp()
        }
        self.userReturnedToAppNotificationObserver = NotificationCenter.default.addObserver(forName: Notification.Name.UserReturnedToAppNotification, object: nil, queue: nil) { _ in
            self.userReturnedToApp()
        }
    }
    func destruct() {
        if let observer = self.userLeftLockedAppNotificationObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = self.userReturnedToAppNotificationObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    func userLeftLockedApp() {
        let content = LocalNotificationController.shared.localNotificationContent(title: "Go back to sleep! 😴", body: "Tap here to go back.", subtitle: "You should not use your phone right now.", badge: 1)
        LocalNotificationController.shared.sendLocalNotification(identifier: localNotificationIdentifier, content: content, trigger: LocalNotificationController.timeIntervalTrigger(8.0))
    }

    func userReturnedToApp() {
        LocalNotificationController.shared.notificationCenter.removePendingNotificationRequests(withIdentifiers: [self.localNotificationIdentifier])
        LocalNotificationController.shared.notificationCenter.removeDeliveredNotifications(withIdentifiers: [self.localNotificationIdentifier])
    }
}
