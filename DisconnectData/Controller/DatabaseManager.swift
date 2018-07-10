//
//  DatabaseManager.swift
//  DisconnectData
//
//  Created by Maarten Zonneveld on 30/06/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import Foundation

public enum DatabaseEntity: String {
    case night
}

public class DatabaseManager {

    public init() {

    }

    func databaseDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for document directory!")
        }
    }

    func entityDirectory(for entity: DatabaseEntity) -> URL {

        let url = self.databaseDirectory().appendingPathComponent(entity.rawValue, isDirectory: true)

        var pointer = ObjCBool(true)
        if !FileManager.default.fileExists(atPath: url.path, isDirectory: &pointer) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return url
    }

    func url(for entity: DatabaseEntity, identifier: String) -> URL {
        return self.entityDirectory(for: entity).appendingPathComponent(identifier, isDirectory: false).appendingPathExtension("json")
    }
}

extension DatabaseManager {

    // MARK: Create

    public func save<T: DatabaseModel>(_ entity: DatabaseEntity, identifier: String, model: T) throws -> Bool {
        let data = try JSONEncoder().encode(model)
        return try self.save(entity: entity, identifier: identifier, data: data)
    }

    private func save(entity: DatabaseEntity, identifier: String, data: Data) throws -> Bool {

        let fileURL = self.url(for: entity, identifier: identifier)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }

        return FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
    }
}

extension DatabaseManager {

    // MARK: Read

    public func findAllIdentifiers(_ entity: DatabaseEntity) throws -> [String] {

        let entityDirectory = self.entityDirectory(for: entity)

        var pointer = ObjCBool(true)
        if !FileManager.default.fileExists(atPath: entityDirectory.path, isDirectory: &pointer) {
            return []
        }

        let contents = try FileManager.default.contentsOfDirectory(at: entityDirectory, includingPropertiesForKeys: nil, options: [])
        let identifiers = contents.map { url -> String in
            url.deletingPathExtension().lastPathComponent
        }
        return identifiers
    }

    public func findOne<T: DatabaseModel>(_ entity: DatabaseEntity, identifier: String) throws -> T? {

        guard let data = self.findData(entity: entity, identifier: identifier) else {
            return nil
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    private func findData(entity: DatabaseEntity, identifier: String) -> Data? {

        let fileURL = self.url(for: entity, identifier: identifier)

        return FileManager.default.contents(atPath: fileURL.path)
    }
}
