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
        init(
            apiClient: APIClientProtocol = DI.resolve()
        ) {
        }
    }
}
