//
//  API.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation

// MARK: Endpoints
enum API {
    /// `City searching` endpoint
    case geocoding(String)

    /// `Next 8 Forecasts` endpoint
    case forecasts(city: City)
}

// MARK: For APIClient
extension API {
    var baseURL: URL {
        URL(string: "http://api.openweathermap.org/")!
    }

    var path: String {
        switch self {
        case .geocoding: "geo/1.0/direct"
        case .forecasts: "data/2.5/forecast"
        }
    }

    var queries: [URLQueryItem] {
        switch self {
        case .geocoding(let value):
            [
                URLQueryItem(name: "q", value: value),
                URLQueryItem(name: "limit", value: "3"),
                URLQueryItem(name: "appid", value: .openWeatherAppId)
            ]

        case .forecasts(let city):
            [
                URLQueryItem(name: "lat", value: "\(city.lat)"),
                URLQueryItem(name: "lon", value: "\(city.lon)"),
                URLQueryItem(name: "cnt", value: "\(Int.maxForecastNumber)"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: .openWeatherAppId)
            ]
        }
    }

    var url: URL {
        baseURL.appending(path: path).appending(queryItems: queries)
    }
}

// MARK: Constants
private extension String {
    static let openWeatherAppId = "df15e8fccf875ae0b2825ad32cb65e74"
}

extension Int {
    static let maxForecastNumber = 8
}
