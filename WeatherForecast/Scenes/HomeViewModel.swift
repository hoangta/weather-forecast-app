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
        
        init() {
            APIClient().request(.geocoding("Ha noi"), for: [City].self)
                .sink { completion in
                    print("completion", completion)
                } receiveValue: { cities in
                    print("city", cities)
                }
                .store(in: &cancellable)
        }
    }
}
