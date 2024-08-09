//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var searchText: String = ""
        @Published var searchResults: [City] = []
        @Published var cities: [City] = []
    }
}
