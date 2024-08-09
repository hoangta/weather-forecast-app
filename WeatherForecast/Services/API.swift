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
}

// MARK: For APIClient
extension API {
    var baseURL: URL {
        switch self {
        case .geocoding:
            URL(string: "http://api.openweathermap.org/")!
        }
    }

    var path: String {
        switch self {
        case .geocoding: "geo/1.0/direct"
        }
    }

    private var defaultQueries: [URLQueryItem] {
        [URLQueryItem(name: "limit", value: "3"),
         URLQueryItem(name: "appid", value: .openWeatherAppId)]
    }

    var queries: [URLQueryItem] {
        switch self {
        case .geocoding(let value): [URLQueryItem(name: "q", value: value)] + defaultQueries
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
