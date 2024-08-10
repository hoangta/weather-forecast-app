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

        private var cancellable = Set<AnyCancellable>()

        init(
            apiClient: APIClientProtocol = DI.resolve(),
            realm: Realm = DI.resolve()
        ) {
            cities = realm.objects(City.self)

            $searchText
            // Reduce network calls, also switch to background thread
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            // There is an issue when binding searchText that cause every change emit 2 times
            // This also happen when binding via TextField
            // https://forums.swift.org/t/why-published-var-didset-is-called-extra-time-when-its-referenced-by-textfield-binding/52940/10
                .removeDuplicates()
            // .map + .switchToLatest = .flatMapLatest in rxswift, i.e we only want the latest result
                .map { text -> AnyPublisher<[City], Never> in
                    // Only cater for search text with 2 or more character, otherwise return empty
                    if text.count < 2 {
                        return Just([]).eraseToAnyPublisher()
                    } else {
                        return apiClient.request(.geocoding(text), for: [City].self)
                            .replaceError(with: [City]())
                            .eraseToAnyPublisher()
                    }
                }
                .switchToLatest()
            // Switch back to main thread for UI updates
                .receive(on: DispatchQueue.main)
                .assign(to: &$searchResults)
        }
    }
}
