//
//  CityDetailView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import SwiftUI
import RealmSwift

struct CityDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewModel()
    @ObservedRealmObject var city: City
    
    var body: some View {
        VStack {
            temperatureListView
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(city.displayName)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
            favoriteButton
        }
    }
}

// MARK: - UIs
private extension CityDetailView {
    var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left")
                    .bold()
            }
        }
    }

    var favoriteButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            FavoriteButton(isFavorite: $city.isFavorite)
        }
    }

    var temperatureListView: some View {
        HStack {
            ForEach(viewModel.forecasts, id: \.time) { forecast in
                VStack {
                    Text(forecast.time.formatted(Date.FormatStyle().hour()))
                    if let icon = forecast.weather?.icon {
                        Image(systemName: icon)
                            .frame(height: 30)
                    }
                    Text(forecast.temperature.current.formatted(style: .temperature))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}

#Preview("Plain") {
    let city = try! [City.Raw].from(file: "cities").map(City.init).first!
    return CityDetailView(city: city)
}

#Preview("In a NavigationStack") {
    struct Preview: View {
        let city: City

        var body: some View {
            NavigationStack {
                Color.clear
                    .navigationDestination(isPresented: .constant(true)) {
                        CityDetailView(city: city)
                    }
            }
        }
    }

    let city = try! [City.Raw].from(file: "cities").map(City.init).first!
    return Preview(city: city)
}
