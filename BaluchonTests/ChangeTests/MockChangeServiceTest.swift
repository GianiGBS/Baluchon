//
//  MockChangeServiceTest.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 24/03/2023.
//
// swiftlint:disable unused_closure_parameter

import XCTest
@testable import Baluchon

class MockChangeServiceTestCase: XCTestCase {

    var changeService: ChangeService!

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        changeService = ChangeService(changeSession: urlSession)
      }
    func testGetChangeShouldPostFailedCallbackIfError() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = FakeResponseData.error
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetChangeShouldPostFailedCallbackIfNoData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetChangeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.changeCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseKO
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetChangeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.incorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetChangeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.changeCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            let result = 1.070388

            XCTAssertTrue(success)
            XCTAssertNotNil(change)

            XCTAssertEqual(result, change?.result)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
