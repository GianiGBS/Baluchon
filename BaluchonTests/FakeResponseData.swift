//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 14/03/2023.
//
// swiftlint:disable force_try

import Foundation

class FakeResponseData {
    // MARK: - Status code
    static let responseOK =  HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)

    // MARK: - Error
    class BasicError: Error {}
    static let error = BasicError()

    // MARK: - Change
    static var changeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Change", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // MARK: - Translate
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // MARK: - Weather
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // MARK: - Incorrect Data
    static let incorrectData = "erreur".data(using: .utf8)!
}
