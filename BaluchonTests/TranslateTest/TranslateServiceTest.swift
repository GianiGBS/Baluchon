//
//  TranslateServiceTest.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 01/03/2023.
//

import XCTest
@testable import Baluchon

class TranslateServiceTestCase: XCTestCase {
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error))

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

    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: nil,
            response: nil,
            error: nil))

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

    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))

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
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

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
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(with: "error") { success, translate in
            // Then
            let text = "Good morning"

            XCTAssertTrue(success)
            XCTAssertNotNil(translate)

            XCTAssertEqual(text, translate!.data.translations[0].translatedText)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
