//
//  LocalNotificationController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 07/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation
import UIKit.UIApplication
import UserNotifications

internal final class LocalNotificationController: NSObject {

    private var UIApplicationDidBecomeActiveObserver: Any?

    static let shared = LocalNotificationController()

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self

        self.UIApplicationDidBecomeActiveObserver = NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: nil) { _ in
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }

    func requestAuthorization(completion: ((_ granted: Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
            completion?(granted)
        }
    }

    func localNotificationContent(title: String? = nil,
                                  body: String,
                                  subtitle: String? = nil,
                                  sound: UNNotificationSound? = .default(),
                                  categoryIdentifier: String? = nil,
                                  badge: Int? = nil,
                                  userInfo: [AnyHashable: Any]? = nil) -> UNNotificationContent {

        let content = UNMutableNotificationContent()
        if let title = title {
            content.title = title
        }
        content.body = body
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        content.sound = sound
        if let categoryIdentifier = categoryIdentifier {
            content.categoryIdentifier = categoryIdentifier
        }
        if let badge = badge {
            content.badge = NSNumber(value: badge)
        }
        if let userInfo = userInfo {
            content.userInfo = userInfo
        }
        return content
    }

    func sendLocalNotification(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger? = nil, completion: ((Error?) -> Swift.Void)? = nil) {
        DispatchQueue.main.async {

            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])

            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
        }
    }
}

extension LocalNotificationController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
