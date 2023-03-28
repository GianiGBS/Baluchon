//
//  MockTranslateServiceTest.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 25/03/2023.
//
// swiftlint:disable unused_closure_parameter

import XCTest
@testable import Baluchon

class MockTranslateServiceTestCase: XCTestCase {

    var translateService: TranslateService!

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        translateService = TranslateService(translateSession: urlSession)
      }
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = FakeResponseData.error
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(with: "error") { success, translate in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(with: "error") { success, translate in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.translateCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseKO
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(with: "error") { success, translate in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.incorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(with: "error") { success, translate in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let data: Data? = FakeResponseData.translateCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(with: "error") { success, translate in
            // Then
            let text = "Good morning"

            XCTAssertTrue(success)
            XCTAssertNotNil(translate)

            XCTAssertEqual(text, translate?.data.translations[0].translatedText)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
