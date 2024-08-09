//
//  HomeView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Content()
                .navigationTitle("Weather Forecast")
                .searchable(text: $viewModel.searchText, prompt: "Search for a city")
                .environmentObject(viewModel)
        }
    }
}

extension HomeView {
    struct Content: View {
        @Environment(\.isSearching) private var isSearching
        @EnvironmentObject private var viewModel: ViewModel

        var body: some View {
            ScrollView {
                LazyVStack {
                    if isSearching {
                        ForEach(viewModel.searchResults) { city in
                            Text(city.name)
                        }
                    } else {
                        ForEach(viewModel.cities) { city in
                            Text(city.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    APIClientPreview.shared.requestPreview = { _ in
        [City].from(file: "cities")
    }
    return HomeView()
}
