//
//  Double+Format.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation

extension Double {
    enum FormatStyle {
        case temperature
    }

    func formatted(style: FormatStyle) -> String {
        switch style {
        case .temperature:
            "\(Int(self))°"
        }
    }

    var temperatureDisplay: String {
        "\(Int(self))°"
    }
}
