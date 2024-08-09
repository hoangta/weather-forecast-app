//
//  DI.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation

enum DI {
    static let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
