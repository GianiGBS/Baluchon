//
//  NetWorkManagement.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation
import UIKit

// MARK: - Enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - Verified Key
func verifiedKey(accesKey: String) -> String {
    let apiKey = Bundle.main.object(forInfoDictionaryKey: accesKey) as? String

    guard let key = apiKey, !key.isEmpty else {
        return "API key does not exist"
    }
    return "\(key)"
}

// MARK: - View Protocol
protocol ViewDelegate: AnyObject {
    func updateView()
    func toggleActivityIndicator(shown: Bool)
    func presentAlert(title: String, message: String)
}

// MARK: - Weather list
var icons = [
// Clear sky
    "01d": "sun.max",
    "01n": "moon.stars",
// Few cloud
    "02d": "cloud.sun",
    "02n": "cloud.moon",
// Scattered clouds
    "03d": "cloud",
    "03n": "cloud",
// Broken clouds
    "04d": "smoke",
    "04n": "smoke",
// Shower rain
    "09d": "cloud.rain",
    "09n": "cloud.rain",
// Rain
    "10d": "cloud.sun.rain",
    "10n": "cloud.moon.rain",
// Thunderstorm
    "11d": "cloud.sun.bolt",
    "11n": "cloud.moon.bolt",
// Snow
    "13d": "snowflake",
    "13n": "snowflake",
// Mist
    "50d": "sun.haze",
    "50n": "moon.haze"
    ]
