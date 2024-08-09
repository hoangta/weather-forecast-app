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

                } label: {
                    CityResultView(city: city)
                }
                .foregroundStyle(.primary)
            }
        }

        private var favoriteCities: some View {
            ForEach(viewModel.cities, content: CityView.init)
        }
    }
}

#Preview {
    let cities = [City].from(file: "cities")
    try! Realm.inMemory.write {
        Realm.inMemory.add(cities)
    }
    APIClientPreview.shared.requestPreview = { _ in
        [cities[0], cities[1]]
    }
    return HomeView()
}
