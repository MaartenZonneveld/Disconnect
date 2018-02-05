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
//    func 
}

internal final class MorningActivityController {

    private let motionActivityManager = CMMotionActivityManager()
    private weak var timer: Timer?

    init() {
        self.goodMorning()
    }

    func goodMorning() {

        print("Good Morning!")
        print("Get out of bed and start walking!")

        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
            self.checkIfUserDidWalk()
        })
        self.timer?.tolerance = 0.5
    }

    private func userDidMove() {
        self.timer?.invalidate()

        print("User did walk!")
        print("Device is now free to use.")
        print("Have a good day!")
    }
    private func userDidNotMove() {
         print("C'mon get out!")
    }

    private func checkIfUserDidWalk() {

        MotionActivityProvider().analyzeMovement(since: -10.0, till: 0.0, success: { didMove in
            if didMove {
                self.userDidMove()
            } else {
                self.userDidNotMove()
            }
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
