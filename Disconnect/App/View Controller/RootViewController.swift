//
//  RootViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal final class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let activityViewController: EveningActivityViewController
        do {
            activityViewController = try EveningActivity.factory(for: EveningActivityViewController.self).initialViewController()
        } catch {
            fatalError(error.localizedDescription)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }

    func resetRoot(animated: Bool, completion: (() -> Void)? = nil) {
        let activityViewController: EveningActivityViewController
        do {
            activityViewController = try EveningActivity.factory(for: EveningActivityViewController.self).initialViewController()
        } catch {
            fatalError(error.localizedDescription)
        }
        self.presentRoot(activityViewController, animated: animated, completion: completion)
    }

    func presentRoot(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismiss(animated: true, completion: {
                self.present(viewControllerToPresent, animated: animated, completion: completion)
            })
            return
        }

        self.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
