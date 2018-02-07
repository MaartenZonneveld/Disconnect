//
//  EveningActivityViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class EveningActivityViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var startSleepButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let gradientView = self.view as? GradientView else {
            fatalError("Expected self.view to be of type `GradientView`")
        }

        gradientView.startColor = .eveningDarkBackgroundColor
        gradientView.endColor = .eveningLightBackgroundColor

        self.titleLabel.font = .primaryHeader
        self.titleLabel.textColor = .primaryTintColor

        self.startSleepButton.tintColor = .darkContentTintColor
        self.startSleepButton.backgroundColor = .primaryTintColor
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.startSleepButton.layer.cornerRadius = self.startSleepButton.frame.height / 2.0
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

internal extension EveningActivityViewController {
    // MARK: UI Actions

    @IBAction private func startSleepButtonPressed(_ sender: Any) {
        let activityViewController: NightActivityViewController
        do {
            activityViewController = try NightActivity.factory(for: NightActivityViewController.self).initialViewController()
        } catch {
            fatalError(error.localizedDescription)
        }

        AppDelegate.shared.appWindow.rootViewController().presentRoot(activityViewController, animated: true, completion: nil)
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {

    }
}
