//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import Combine

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var searchText: String = ""
        @Published var searchResults: [City] = []
        @Published var cities: [City] = []

        private var cancellable = Set<AnyCancellable>()

        init(apiClient: APIClientProtocol = DI.resolve()) {
            $searchText
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
                .filter { $0.count >= 2 }
                .removeDuplicates()
                .map { apiClient.request(.geocoding($0), for: [City].self) }
                .switchToLatest()
                .replaceError(with: [City]())
                .receive(on: DispatchQueue.main)
                .assign(to: &$searchResults)
        }
    }
}
