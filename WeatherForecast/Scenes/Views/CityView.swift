//
//  CityView.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import SwiftUI

struct CityView: View {
    let city: City

    var body: some View {
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
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 8))
    }
}
