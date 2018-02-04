//
//  MotionActivityProvider.swift
//
//  Created by Maarten Zonneveld on 08/11/2017.
//  Copyright © 2017 Digitalisma. All rights reserved.
//

import CoreMotion
import Foundation

internal final class MotionActivityProvider {

    class MotionActivityProviderError: Error {
        var description: String

        init(description: String) {
            self.description = description
        }

        var localizedDescription: String {
            return NSLocalizedString(self.description, comment: "")
        }
    }

    func analyzeMovement(since: TimeInterval, till: TimeInterval, success: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void) {

        let now = Date()
        let sinceDate = now.addingTimeInterval(since)
        let tillDate = now.addingTimeInterval(till)

        CMMotionActivityManager().queryActivityStarting(from: sinceDate, to: tillDate, to: .main) { activities, error in

            if let error = error {
                failure(MotionActivityProviderError(description: error.localizedDescription))
                return
            }

            // Filter away all activities with low confidence
            let activities = activities?.filter({ activity -> Bool in
                activity.confidence != .low
            }) ?? []

            if activities.isEmpty {
                success(true)
                return
            }

            var didMove = false

            for activity in activities {

//                if !activity.stationary {
//                    didMove = true
//                    break
//                }

                let activitiesOtherThanStationary =
                    activity.automotive ||
                    activity.running ||
                    activity.walking ||
                    activity.cycling ||
                    activity.unknown

                if activitiesOtherThanStationary {
                    didMove = true
                    break
                }
            }

            success(didMove)
        }
    }
}
