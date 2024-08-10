//
//  Data+File.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation

extension Data {
    init(file: String) throws {
        let url = Bundle.main.url(forResource: file, withExtension: "json")!
        self = try Data(contentsOf: url)
    }
}
