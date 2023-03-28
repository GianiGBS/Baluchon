//
//  ChangeServiceTest.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 01/03/2023.
//

import XCTest
@testable import Baluchon

class ChangeServiceTestCase: XCTestCase {

    func testGetChangeShouldPostFailedCallbackIfError() {
        // Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: nil,
                                                                        response: nil,
                                                                        error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetChangeShouldPostFailedCallbackIfNoData() {
        // Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: nil,
                                                                        response: nil,
                                                                        error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetChangeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: FakeResponseData.changeCorrectData,
                                                                        response: FakeResponseData.responseKO,
                                                                        error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetChangeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: FakeResponseData.incorrectData,
                                                                        response: FakeResponseData.responseOK,
                                                                        error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetChangeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: FakeResponseData.changeCorrectData,
                                                                        response: FakeResponseData.responseOK,
                                                                        error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue chnage")
        changeService.getChange(with: "error") { success, change in
            // Then
            let result = 1.070388

            XCTAssertTrue(success)
            XCTAssertNotNil(change)

            XCTAssertEqual(result, change!.result)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
