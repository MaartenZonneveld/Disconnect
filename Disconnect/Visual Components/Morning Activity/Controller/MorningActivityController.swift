//
//  MorningActivityController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 04/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import CoreMotion
import Foundation

internal protocol MorningActivityControllerDelegate: class {
    func userDidMove()
    func userDidNotMove()
}

internal final class MorningActivityController {

    private let motionActivityManager = CMMotionActivityManager()
    private weak var timer: Timer?

    private weak var delegate: MorningActivityControllerDelegate?

    func goodMorning(delegate: MorningActivityControllerDelegate) {
        self.delegate = delegate

        self.timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true, block: { [weak self] _ in
            self?.checkIfUserDidWalk()
        })
        self.timer?.tolerance = 0.5
    }

    private func userDidMove() {
        self.timer?.invalidate()
        self.delegate?.userDidMove()
    }
    private func userDidNotMove() {
        self.delegate?.userDidNotMove()
    }

    private func checkIfUserDidWalk() {

        MotionActivityProvider().scanForWalkActivity(since: -4.0, minimalConfidence: .medium, success: { isWalking in
            if isWalking {
                self.userDidMove()
            } else {
                self.userDidNotMove()
            }
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
