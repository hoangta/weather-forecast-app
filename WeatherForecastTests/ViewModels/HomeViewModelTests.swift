//
//  HomeViewModelTests.swift
//  WeatherForecastTests
//
//  Created by Hoang Ta on 10/8/24.
//

import XCTest
import Combine
import RealmSwift
@testable import WeatherForecast

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeView.ViewModel!
    private var realm: Realm!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        realm = .inMemory
        viewModel = .init(
            apiClient: APIClient(urlSession: URLSession.mock),
            realm: realm,
            debounce: .immediate
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

    func test_cityList_whenAppear_shouldLoadFavoriteCities() throws {
        // Given
        let cities = try! [City.Raw].from(file: "cities").map(City.init)
        for city in cities {
            city.isFavorite = true
        }
        try realm.write {
            realm.add(cities[0...2])
        }

        // Then
        XCTAssert(!viewModel.cities.isEmpty)
        for city in viewModel.cities {
            XCTAssert(city.isFavorite)
        }
    }

    func test_cityResultList_whenSearchWithOneOrLessCharacter_shouldBeEmpty() throws {
        // Given
        let expectation = expectation(description: "City results should be empty" )

        // When
        viewModel.searchText = "A"

        // Then
        viewModel
            .$searchResults
            .sink(receiveValue: { cities in
                XCTAssert(cities.isEmpty, "City count: \(cities.count)")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.1)
    }

    func test_cityResultList_whenSearchWithTwoOrMoreCharacter_shouldNotBeEmpty() throws {
        // Given
        let expectation = expectation(description: "City results should not be empty" )
        let data = try Data(file: "cities")
        URLProtocolMock.requestData = { _ in data }

        // When
        viewModel.searchText = "Ha"

        // Then
        viewModel
            .$searchResults
            .filter { !$0.isEmpty }
            .sink(receiveValue: { cities in
                XCTAssert(!cities.isEmpty, "City count: \(cities.count)")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
}
