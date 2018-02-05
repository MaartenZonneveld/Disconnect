//
//  EveningActivityViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class EveningActivityViewController: UIViewController {

    @IBOutlet private weak var startSleepButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func startSleepButtonPressed(_ sender: Any) {
        let nightActivityViewController: NightActivityViewController
        do {
            nightActivityViewController = try NightActivity.factory(for: NightActivityViewController.self).initialViewController()
        } catch {
            fatalError(error.localizedDescription)
        }
        self.show(nightActivityViewController, sender: nil)
    }
}
