//
//  NightsViewController.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 08/03/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import DisconnectData
import UIKit

internal final class NightsViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let manager = DatabaseManager()

        let nights: [String]

        do {
            nights = try manager.findAllIdentifiers(.night)
        } catch {
            fatalError(error.localizedDescription)
        }

        print(nights)

        nights.forEach({ identifier in
            let night: Night?
            do {
                night = try manager.findOne(.night, identifier: identifier)
            } catch {
                fatalError(error.localizedDescription)
            }
            print(night as Any)
        })
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.saveNight()
    }

    func saveNight() {

        let night = Night(version: 1, startDate: Date().addingTimeInterval(-4243.0), endDate: Date(), events: [])

        do {
            let success = try DatabaseManager().save(.night, identifier: UUID().uuidString, model: night)
            print(success)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
