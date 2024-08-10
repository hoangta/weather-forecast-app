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
            HStack {
                Text(city.name)
                    .font(.headline)
                Spacer()
                Text(city.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 8))
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
}

#Preview("Plain") {
    let city = [City].from(file: "cities").first!
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

    let city = [City].from(file: "cities").first!
    return Preview(city: city)
}
