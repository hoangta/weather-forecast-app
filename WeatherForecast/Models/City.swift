//
//  City.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import RealmSwift

class City: Object, ObjectKeyIdentifiable, Decodable {
    @Persisted var name: String
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var country: String
    @Persisted var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
        case country
        case isFavorite
    }

    required init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        lat = try values.decode(Double.self, forKey: .lat)
        lon = try values.decode(Double.self, forKey: .lon)
        country = try values.decode(String.self, forKey: .country)
        isFavorite = false
    }

    override init() {
        super.init()
    }
}

extension City {
    var displayName: String {
        "\(name), \(country)"
    }
}
