//
//  VisualComponent.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 22/11/2017.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit

internal protocol VisualComponent {
    static var storyboardName: String { get }
}

extension VisualComponent {

    private static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }

    static func factory<ViewControllerType>(for type: ViewControllerType.Type) -> ViewControllerFactory<ViewControllerType> {
        return ViewControllerFactory(storyboard: self.storyboard())
    }
}

internal struct ViewControllerFactory<ViewControllerType> where ViewControllerType: UIViewController {

    struct RuntimeError: Error {

        var description: String

        var localizedDescription: String {
            return NSLocalizedString(self.description, comment: "")
        }
    }

    var storyboard: UIStoryboard

    func initialViewController() throws -> ViewControllerType {
        if let viewController = self.storyboard.instantiateInitialViewController() as? ViewControllerType {
            return viewController
        }
        throw RuntimeError(description: "Could not instantiate initial view controller of storyboard \(self.storyboard.debugDescription)")
    }

    func viewController(for identifier: String) throws -> ViewControllerType {
        if let viewController = self.storyboard.instantiateViewController(withIdentifier: identifier) as? ViewControllerType {
            return viewController
        }
        throw RuntimeError(description: "Could not instantiate view controller with identifier '\(identifier)' of storyboard \(self.storyboard.debugDescription)")
    }
}

internal protocol ViewControllerFactoryCreatable {
    static func viewControllerIdentifier(for storyboard: UIStoryboard) -> String
}

extension ViewControllerFactory where ViewControllerType: ViewControllerFactoryCreatable {

    func viewController() throws -> ViewControllerType {
        let identifier = ViewControllerType.viewControllerIdentifier(for: self.storyboard)
        return try self.viewController(for: identifier)
    }
}
