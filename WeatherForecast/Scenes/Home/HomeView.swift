//
//  HomeView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Content()
                .navigationTitle("Weather Forecast")
                .searchable(text: $viewModel.searchText, prompt: "Search for a city")
                .environmentObject(viewModel)

        }
        .foregroundStyle(.primary)
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
                        searchResults
                    } else {
                        favoriteCities
                    }
                }
                .padding()
            }
            .overlay {
                if !isSearching && viewModel.cities.isEmpty {
                    NoFavoriteCitiesView()
                }
            }
        }

        private var searchResults: some View {
            ForEach(viewModel.searchResults) { city in
                NavigationLink {
                    CityDetailView(city: city)
                } label: {
                    CityResultView(city: city)
                }
            }
        }

        private var favoriteCities: some View {
            ForEach(viewModel.cities) { city in
                NavigationLink {
                    CityDetailView(city: city)
                } label: {
                    CityView(city: city)
                }
            }
        }
    }
}

#Preview {
    let cities = try! [City].from(file: "cities")
    try! Realm.inMemory.write {
        Realm.inMemory.add(cities[0...2])
    }
    APIClientPreview.shared.requestPreview = { _ in
        [cities[3], cities[4]]
    }
    return HomeView()
}
