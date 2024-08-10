//
//  HomeViewModelTests.swift
//  WeatherForecastTests
//
//  Created by Hoang Ta on 10/8/24.
//

import XCTest
import Combine
@testable import WeatherForecast

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeView.ViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = .init(
            apiClient: APIClient(urlSession: URLSession.mock),
            realm: .inMemory
        )
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func test_initialFavoriteCityList_shouldBeEmpty() throws {
        XCTAssert(viewModel.cities.isEmpty)
    }

    func test_cityResultList_whenSearchWithOneOrLessCharacter_shouldBeEmpty() throws {
//        let expectation = expectation(description: "City results should be empty" )
        viewModel.searchText = "A"
        XCTAssert(viewModel.cities.isEmpty)
//        wait(for: [expectation], timeout: 0.1)
    }

    func test_cityResultList_whenSearchWithTwoOrMoreCharacter_shouldNotBeEmpty() throws {
        // Given
        let expectation = expectation(description: "City results should be empty" )
        let data = try Data(file: "cities")
        URLProtocolMock.requestData = { _ in data }

        // When
        viewModel.searchText = "Ha"

        // Then
        viewModel
            .$searchResults
            .dropFirst()
            .sink(receiveValue: { cities in
                XCTAssert(!cities.isEmpty, "City count: \(cities.count)")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
}
