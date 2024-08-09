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
            .overlay {
                if !isSearching && viewModel.cities.isEmpty {
                    NoFavoriteCitiesView()
                }
            }
        }
    }
}

#Preview {
    let cities = [City].from(file: "cities")
    let oneCity = cities[0]
    try! Realm.inMemory.write {
        Realm.inMemory.add(cities)
    }
    APIClientPreview.shared.requestPreview = { _ in
        [oneCity]
    }
    return HomeView()
}
