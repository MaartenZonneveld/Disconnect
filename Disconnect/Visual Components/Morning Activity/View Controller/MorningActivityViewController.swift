//
//  MorningActivityViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 05/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class MorningActivityViewController: UIViewController {

    private let morningActivityController = MorningActivityController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.morningActivityController.goodMorning(delegate: self)
    }
}

extension MorningActivityViewController: MorningActivityControllerDelegate {

    func userDidNotMove() {
    }

    func userDidMove() {
        self.dismiss(animated: true, completion: nil)
    }
}
