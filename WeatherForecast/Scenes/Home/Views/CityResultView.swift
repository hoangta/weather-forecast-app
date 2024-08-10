//
//  CityResultView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import SwiftUI

struct CityResultView: View {
    let city: City

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
            .frame(maxWidth: .infinity)
            .padding()
            Divider()
        }
    }
}
