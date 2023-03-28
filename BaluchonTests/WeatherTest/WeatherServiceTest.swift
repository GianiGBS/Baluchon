//
//  WeatherServiceTest.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 01/03/2023.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil,
            response: nil,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            let name = "New York"

            XCTAssertTrue(success)
            XCTAssertNotNil(weather)

            XCTAssertEqual(name, weather?.name)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
