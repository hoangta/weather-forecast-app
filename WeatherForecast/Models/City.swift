//
//  City.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation

struct City {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}

extension City: Identifiable {
    var id: String {
        name + country
    }
}
