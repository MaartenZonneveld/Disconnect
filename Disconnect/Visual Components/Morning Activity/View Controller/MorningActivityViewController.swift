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
    @IBOutlet weak var hurryButton: UIButton!

    private let morningActivityController = MorningActivityController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDidNotMove()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.morningActivityController.goodMorning(delegate: self)
    }

    @IBAction func hurryButtonPressed(_ sender: Any) {

        let alertController = UIAlertController(title: "In a hurry?", message: "Stopping right now will ruin your statistics! Walking around will just take a few seconds.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "I NEED to go NOW 🏃‍♀️", style: .destructive, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))

        let preferredAction = UIAlertAction(title: "I will walk first", style: .default, handler: nil)
        alertController.addAction(preferredAction)
        alertController.preferredAction = preferredAction
        self.showDetailViewController(alertController, sender: nil)
    }
}

extension MorningActivityViewController: MorningActivityControllerDelegate {

    func userDidNotMove() {
        self.statusLabel.text = "C'mon, get out!"
    }

    func userDidMove() {
        self.statusLabel.text = "Have a nice day 😎"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
