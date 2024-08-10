//
//  APIClientTests.swift
//  WeatherForecastTests
//
//  Created by Hoang Ta on 10/8/24.
//

import XCTest
import Combine
@testable import WeatherForecast

final class APIClientTests: XCTestCase {
    private var apiClient: APIClient!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        apiClient = .init(urlSession: .mock)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        apiClient = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func test_apiClient_whenSearchForACity_shouldNotBeEmpty() throws {
        // Given
        let expectation = expectation(description: "City results should be empty" )

        // When
        let data = try Data(file: "cities")
        URLProtocolMock.requestData = { _ in data }

        // Then
        apiClient.request(.geocoding("a city"), for: [City.Raw].self)
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { cities in
                XCTAssert(!cities.isEmpty, "City count: \(cities.count)")
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
}
