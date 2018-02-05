//
//  AppPresenter.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class AppPresenter {

    private(set) var window: AppWindow!

    func setup() {
        let window = AppWindow(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindowLevelNormal
        window.setup()
        window.makeKeyAndVisible()
        self.window = window

        self.showMainContent()
    }

    func showMainContent() {
        let eveningActivityViewController: EveningActivityViewController
        do {
            eveningActivityViewController = try EveningActivity.factory(for: EveningActivityViewController.self).initialViewController()
        } catch {
            fatalError(error.localizedDescription)
        }
        self.window.rootViewController = eveningActivityViewController
    }
}
