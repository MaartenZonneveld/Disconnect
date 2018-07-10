//
//  Night.swift
//  DisconnectData
//
//  Created by Maarten Zonneveld on 30/06/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation

public struct Night: DatabaseModel {

    public var version: Int

    public var startDate: Date
    public var endDate: Date

    public var events: [Event]

    public init(version: Int, startDate: Date, endDate: Date, events: [Event]) {
        self.version = version
        self.startDate = startDate
        self.endDate = endDate
        self.events = events
    }
}

public extension Night {

    func duration() -> TimeInterval {
        return self.endDate.timeIntervalSince(self.startDate)
    }

    func score() -> Int {
        // TODO
        return 0
    }
}
