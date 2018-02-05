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

    func analyzeMovement(since: TimeInterval, minimalConfidence: CMMotionActivityConfidence, success: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void) {

        let now = Date()
        let sinceDate = now.addingTimeInterval(since)

        CMMotionActivityManager().queryActivityStarting(from: sinceDate, to: now, to: .main) { activities, error in

            if let error = error {
                failure(MotionActivityProviderError(description: error.localizedDescription))
                return
            }

            // Filter away all activities with low confidence
            let activities = activities?.filter({ activity -> Bool in
                switch minimalConfidence {
                case .high:
                    return activity.confidence == .high
                case .medium:
                    return activity.confidence == .medium || activity.confidence == .high
                case .low:
                    return true
                }
            }) ?? []

            if activities.isEmpty {
                failure(MotionActivityProviderError(description: "No activities"))
                return
            }

            var didMove = false

            for activity in activities {

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
