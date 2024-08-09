//
//  NoFavoriteCitiesView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import SwiftUI

struct NoFavoriteCitiesView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "moon")
                Image(systemName: "sun.max")
                Image(systemName: "cloud")
                Image(systemName: "wind")
            }
            Text("You don't have a favorite city yet!")
        }
    }
}
