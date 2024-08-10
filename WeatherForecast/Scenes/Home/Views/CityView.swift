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
        HStack(alignment: .bottom, spacing: 0) {
            Text("\(city.name) ")
                .font(.headline)
            Text(city.country)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 8))
    }
}
