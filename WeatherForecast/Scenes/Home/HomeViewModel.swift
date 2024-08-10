//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import Combine
import RealmSwift

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var searchText: String = ""
        @Published var searchResults: [City] = []
        @Published var cities: Results<City>

        private let apiClient: APIClientProtocol
        private let realm: Realm
        private var cancellables = Set<AnyCancellable>()

        init<S: Scheduler>(
            apiClient: APIClientProtocol = DI.resolve(),
            realm: Realm = DI.resolve(),
            debounce: Debounce<S> = .default
        ) {
            self.apiClient = apiClient
            self.realm = realm
            cities = realm.objects(City.self).where { city in
                city.isFavorite
            }

            $searchText
            // Reduce network calls, also switch to background thread
                .debounce(for: debounce.dueTime, scheduler: debounce.scheduler)
            // There is an issue when binding searchText that cause every change emit 2 times
            // This also happen when binding via TextField
            // https://forums.swift.org/t/why-published-var-didset-is-called-extra-time-when-its-referenced-by-textfield-binding/52940/10
                .removeDuplicates()
            // .map + .switchToLatest = .flatMapLatest in rxswift, i.e we only want the latest result
                .map { [unowned self] in mapTextToCitiesPublisher(text: $0) }
                .switchToLatest()
            // another mapping to cities from raw values
                .map { [unowned self] in mapRawsToCities(raws: $0) }
                .assign(to: &$searchResults)
        }
    }
}

// MARK: - Helpers
private extension HomeView.ViewModel {
    func mapTextToCitiesPublisher(text: String) -> AnyPublisher<[City.Raw], Never> {
        // Only cater for search text with 2 or more character, otherwise return empty
        if text.count < 2 {
            return Just([]).eraseToAnyPublisher()
        } else {
            return apiClient.request(.geocoding(text), for: [City.Raw].self)
                .replaceError(with: [City.Raw]())
                .eraseToAnyPublisher()
        }
    }

    func mapRawsToCities(raws: [City.Raw]) -> [City] {
        var cities: [City] = []
        for raw in raws {
            // Find the existing city or create new if needed
            if let city = realm.object(ofType: City.self, forPrimaryKey: raw.id) {
                cities.append(city)
            } else {
                let city = City(raw: raw)
                try? realm.write {
                    realm.add(city)
                }
                cities.append(city)
            }
        }
        return cities
    }
}
