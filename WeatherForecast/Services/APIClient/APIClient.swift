//
//  APIClient.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import Combine

extension DI {
    static func resolve() -> APIClientProtocol {
        isPreview ? APIClientPreview.shared : APIClient.shared
    }
}

protocol APIClientProtocol {
    func request<T: Decodable>(_ api: API, for type: T.Type) -> AnyPublisher<T, Error>
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let urlSession: URLSession

    init (urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func request<T: Decodable>(_ api: API, for type: T.Type) -> AnyPublisher<T, Error> {
        urlSession
            .dataTaskPublisher(for: api.url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
