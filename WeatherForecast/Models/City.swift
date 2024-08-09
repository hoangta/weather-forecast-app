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
}
