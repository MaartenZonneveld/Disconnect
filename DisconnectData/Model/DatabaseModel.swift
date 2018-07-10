//
//  DatabaseModel.swift
//  DisconnectData
//
//  Created by Maarten Zonneveld on 10/07/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation

public protocol DatabaseModel: Codable {

    var version: Int { get }
}
