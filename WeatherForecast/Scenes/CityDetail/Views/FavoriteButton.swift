//
//  FavoriteButton.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 10/8/24.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool

    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .bold()
        }
    }
}
