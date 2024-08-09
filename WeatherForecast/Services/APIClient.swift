//
//  APIClient.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func request<T: Decodable>(_ api: API, for type: T.Type) -> AnyPublisher<T, Error>
}

final class APIClient: APIClientProtocol {
    func request<T: Decodable>(_ api: API, for type: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: api.url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
