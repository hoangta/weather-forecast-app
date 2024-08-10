//
//  Decodable+File.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation

extension Decodable {
    static func from(file: String) throws -> Self {
        let url = Bundle.main.url(forResource: file, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Self.self, from: data)
    }
}
