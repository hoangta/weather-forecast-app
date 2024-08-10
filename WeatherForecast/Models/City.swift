//
//  City.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import RealmSwift

class City: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var country: String
    @Persisted var isFavorite: Bool

    convenience init(raw: City.Raw) {
        self.init()
        self._id = raw.id
        self.name = raw.name
        self.lat = raw.lat
        self.lon = raw.lon
        self.country = raw.country
        self.isFavorite = false
    }
}

extension City {
    var displayName: String {
        "\(name), \(country)"
    }
}

extension City {
    struct Raw: Decodable {
        let name: String
        let lat: Double
        let lon: Double
        let country: String

        var id: String {
            "\(name)-\(country)"
        }
    }
}
