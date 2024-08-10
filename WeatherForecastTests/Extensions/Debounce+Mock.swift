//
//  Debounce+Mock.swift
//  WeatherForecastTests
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation
import Combine
@testable import WeatherForecast

extension Debounce where S == ImmediateScheduler {
    static var immediate: Debounce<S> {
        Debounce(dueTime: 0, scheduler: ImmediateScheduler.shared)
    }
}
