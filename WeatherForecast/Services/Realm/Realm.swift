//
//  Realm.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import RealmSwift

extension DI {
    static func resolve() -> Realm {
        isPreview ? .inMemory : .default
    }
}

extension Realm {
    static var `default`: Realm { try! Realm() }

    static var inMemory: Realm {
        var config = Realm.Configuration()
        config.inMemoryIdentifier = "preview"
        return try! Realm(configuration: config)
    }
}
