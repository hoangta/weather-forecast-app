//
//  CityDetailViewModel.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation
import RealmSwift

extension CityDetailView {
    final class ViewModel: ObservableObject {
        @Published var forecasts: [Forecast]

        init(
            apiClient: APIClientProtocol = DI.resolve()
        ) {
            self.forecasts = try! ForecastResponse.from(file: "forecasts").values
        }
    }
}
