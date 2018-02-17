//
//  RootViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
