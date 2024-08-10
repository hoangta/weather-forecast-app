//
//  Publisher+Debounce.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation
import Combine

struct Debounce<S: Scheduler> {
    let dueTime: S.SchedulerTimeType.Stride
    let scheduler: S
}

extension Debounce where S == RunLoop {
    static var `default`: Debounce<S> {
        Debounce(dueTime: 0.5, scheduler: RunLoop.main)
    }
}

extension Publisher {
    func debounce<S>(_ debounce: Debounce<S>) -> Publishers.Debounce<Self, S> where S : Scheduler {
        self.debounce(for: debounce.dueTime, scheduler: debounce.scheduler)
    }
}
