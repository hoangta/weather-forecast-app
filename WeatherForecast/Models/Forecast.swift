//
//  Forecast.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation

struct ForecastResponse: Decodable {
    let values: [Forecast]

    enum CodingKeys: String, CodingKey {
        case values = "list"
    }
}

struct Forecast: Decodable {
    struct Temperature: Decodable {
        let current: Double
        let max: Double
        let min: Double
        let feelsLike: Double
        let humidity: Int
        let pressure: Int

        enum CodingKeys: String, CodingKey {
            case current = "temp"
            case max = "temp_max"
            case min = "temp_min"
            case feelsLike = "feels_like"
            case humidity, pressure
        }
    }

    struct Weather: Decodable {
        let title: String
        let icon: String

        enum CodingKeys: String, CodingKey {
            case title = "main"
            case icon
        }

        init(from decoder: any Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decode(String.self, forKey: .title)
            // Icon reference: https://openweathermap.org/weather-conditions
            switch try values.decode(String.self, forKey: .icon) {
            case "01d": icon = "circle.fill"
            case "02d": icon = "cloud.sun.fill"
            case "03d": icon = "icloud.fill"
            case "04d": icon = "smoke.fill"
            case "09d": icon = "cloud.rain.fill"
            case "10d": icon = "cloud.sun.rain.fill"
            case "11d": icon = "cloud.bolt.fill"
            case "13d": icon = "snowflake"
            case "50d": icon = "water.waves"
            case "01n": icon = "circle.fill"
            case "02n": icon = "cloud.moon.fill"
            case "03n": icon = "icloud.fill"
            case "04n": icon = "smoke.fill"
            case "09n": icon = "cloud.rain.fill"
            case "10n": icon = "cloud.moon.rain.fill"
            case "11n": icon = "cloud.bolt.fill"
            case "13n": icon = "snowflake"
            case "50n": icon = "water.waves"
            default: icon = "circle.fill"
            }
        }
    }

    let time: Date
    let temperature: Temperature
    let weather: Weather?
    let visibility: Int

    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temperature = "main"
        case weather, visibility
    }

    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let timeinterval = try values.decode(Double.self, forKey: .time)
        time = Date(timeIntervalSince1970: timeinterval)
        temperature = try values.decode(Temperature.self, forKey: .temperature)
        let weathers = try values.decode([Weather].self, forKey: .weather)
        weather = weathers.first
        visibility = try values.decode(Int.self, forKey: .visibility)
    }
}
