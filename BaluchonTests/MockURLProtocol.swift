//
//  MockURLProtocol.swift
//  BaluchonTests
//
//  Created by Giovanni Gabriel on 20/03/2023.
//
// swiftlint:disable large_tuple

import Foundation
import XCTest
@testable import Baluchon
class MockURLProtocol: URLProtocol {

  override class func canInit(with request: URLRequest) -> Bool {
    // To check if this protocol can handle the given request.
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    // Here you return the canonical version of the request but most of the time you pass the orignal one.
    return request
  }

    static var requestHandler: ((URLRequest) -> (Data?, HTTPURLResponse?, Error?))?

  override func startLoading() {
    // This is where you create the mock response as per your test case and send it to the URLProtocolClient.
      guard let handler = MockURLProtocol.requestHandler else {
          XCTFail("Loading handler is not set.")
          return
      }
          // 2. Call handler with received request and capture the tuple of response and data.
      let (data, response, _) = handler(request)
      if let data = data, let response = response {
          // 3. Send received response to the client.
          client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
          // 4. Send received data to the client.
            client?.urlProtocol(self, didLoad: data)
          // 5. Notify request has been finished.
          client?.urlProtocolDidFinishLoading(self)
        } else {
          // 6. Notify received error.
            class ErrorPrtotocol: Error {}
            let errorProtocol = ErrorPrtotocol()
            client?.urlProtocol(self, didFailWithError: errorProtocol)
        }
  }

  override func stopLoading() {
    // This is called if the request gets canceled or completed.
  }
}
