//
//  AppDelegate.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit.UIApplication

@UIApplicationMain
internal final class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: AppDelegate {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Shared app delegate is not of type `AppDelegate`")
        }
        return shared
    }

    let appPresenter = AppPresenter()
    let autoScreenDimmingController = AutoScreenDimmingController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.appPresenter.setup()

        return true
    }
}
