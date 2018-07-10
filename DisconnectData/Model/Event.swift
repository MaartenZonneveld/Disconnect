//
//  Event.swift
//  DisconnectData
//
//  Created by Maarten Zonneveld on 10/07/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation

public enum EventType: Int, Codable {

    case leftLockedApp
    case returnedToLockedApp
}

public struct Event: DatabaseModel {

    public var version: Int

    var moment: Date
    var type: EventType

    public init(version: Int, moment: Date, type: EventType) {
        self.version = version
        self.moment = moment
        self.type = type
    }
}
