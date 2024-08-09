//
//  HomeView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.isSearching) private var isSearching
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.cities) { city in
                        Text(city.name)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search for a city")
            .navigationTitle("Weather Forecast")
            .overlay(alignment: .top) {
                if !viewModel.searchResults.isEmpty {
                    ForEach(viewModel.searchResults) { city in
                        Text(city.name)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
