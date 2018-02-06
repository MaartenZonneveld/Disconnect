//
//  MorningActivityViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class MorningActivityViewController: UIViewController {

    @IBOutlet private weak var statusLabel: UILabel!

    private let morningActivityController = MorningActivityController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDidNotMove()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.morningActivityController.goodMorning(delegate: self)
    }
}

extension MorningActivityViewController: MorningActivityControllerDelegate {

    func userDidNotMove() {
        self.statusLabel.text = "C'mon, get out!"
    }

    func userDidMove() {
        self.statusLabel.text = "Have a nice day 😎"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            AppDelegate.shared.appWindow.rootViewController().resetRoot(animated: true)
        }
    }
}
