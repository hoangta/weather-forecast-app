//
//  CityDetailViewModel.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation
import Combine
import RealmSwift

extension CityDetailView {
    final class ViewModel: ObservableObject {
        @Published var forecasts: List<Forecast> = .init()
        @Published var isFetching = false

        private let apiClient: APIClientProtocol
        private let realm: Realm
        private var cancellables = Set<AnyCancellable>()

        init(
            apiClient: APIClientProtocol = DI.resolve(),
            realm: Realm = DI.resolve()
        ) {
            self.apiClient = apiClient
            self.realm = realm
        }
    }
}

extension CityDetailView.ViewModel {
    func fetchForecasts(for city: City) {
        // Populate forecasts with cached
        self.forecasts = city.forecasts

        // Only update if no forecast is found
        // Or they have been outdated
        guard city.forecasts.isEmpty || city.forecasts.first!.time < .now else {
            return
        }

        // Show loading only if this is the 1st fetching
        isFetching = city.forecasts.isEmpty
        apiClient
            .request(.forecasts(city: city), for: ForecastResponse.self)
            .map(\.values)
            .sink { [weak self] completion in
                self?.isFetching = false
            } receiveValue: { [weak self] forecasts in
                guard let self,
                      let city = realm.object(ofType: City.self, forPrimaryKey: city._id) else {
                    return
                }
                try? realm.write {
                    city.forecasts = .init()
                    city.forecasts.append(objectsIn: forecasts)
                }
                self.forecasts = city.forecasts
            }
            .store(in: &cancellables)
    }
}
