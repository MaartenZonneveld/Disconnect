//
//  AppDelegate.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Crashlytics
import Fabric
import UIKit.UIApplication

@UIApplicationMain
internal final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var shared: AppDelegate {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Shared app delegate is not of type `AppDelegate`")
        }
        return shared
    }

    let autoScreenDimmingController = AutoScreenDimmingController()
    let appLockController = AppLockController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])

        self.window?.setupAppWindow()

//        LocalNotificationController.shared.requestAuthorization { granted in
//            print(granted)
//        }

        return true
    }
}
