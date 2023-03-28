//
//  MockWeatherServiceTest.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 25/03/2023.
//
// swiftlint:disable unused_closure_parameter

import XCTest
@testable import Baluchon

class MockWeathereServiceTestCase: XCTestCase {

    var weatherService: WeatherService!

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        weatherService = WeatherService(weatherSession: urlSession)
      }
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = FakeResponseData.error
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.weatherCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseKO
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.incorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.weatherCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
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
        wait(for: [expectation], timeout: 1.0)
    }
}
