//
//  APIClientPreview.swift
//  WeatherForecast
//
//  Created by Hoang Ta on 9/8/24.
//

import Foundation
import Combine

final class APIClientPreview: APIClientProtocol {
    static let shared = APIClientPreview()

    var requestPreview: ((API) -> Any)?

    func request<T: Decodable>(_ api: API, for type: T.Type) -> AnyPublisher<T, Error> {
        guard let value = requestPreview?(api) as? T else {
            fatalError("Please provide a value for \(api)")
        }
        return Just(value)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
