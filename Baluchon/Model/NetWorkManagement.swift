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

var color = [
// Clear sky
    "01d": UIColor(red: 249.0, green: 245.0, blue: 75.0, alpha: 1.0),
    "01n": UIColor(red: 16.0, green: 49.0, blue: 107.0, alpha: 1.0),
// Few cloud
    "02d": UIColor(red: 255.0, green: 232.0, blue: 103.0, alpha: 1.0),
    "02n": UIColor(red: 43.0, green: 52.0, blue: 103.0, alpha: 1.0),
// Scattered clouds
    "03d": UIColor(red: 210.0, green: 228.0, blue: 241.0, alpha: 1.0),
    "03n": UIColor(red: 64.0, green: 66.0, blue: 88.0, alpha: 1.0),
// Broken clouds
    "04d": UIColor(red: 143.0, green: 172.0, blue: 192.0, alpha: 1.0),
    "04n": UIColor(red: 71.0, green: 78.0, blue: 104.0, alpha: 1.0),
// Shower rain
    "09d": UIColor(red: 72.0, green: 77.0, blue: 81.0, alpha: 1.0),
    "09n": UIColor(red: 107.0, green: 114.0, blue: 142.0, alpha: 1.0),
// Rain
    "10d": UIColor(red: 129.0, green: 141.0, blue: 151.0, alpha: 1.0),
    "10n": UIColor(red: 80.0, green: 87.0, blue: 122.0, alpha: 1.0),
// Thunderstorm
    "11d": UIColor(red: 72.0, green: 77.0, blue: 81.0, alpha: 1.0),
    "11n": UIColor(red: 107.0, green: 114.0, blue: 142.0, alpha: 1.0),
// Snow
    "13d": UIColor(red: 71.0, green: 181.0, blue: 255.0, alpha: 1.0),
    "13n": UIColor(red: 16.0, green: 49.0, blue: 107.0, alpha: 1.0),
// Mist
    "50d": UIColor(red: 95.0, green: 111.0, blue: 148.0, alpha: 1.0),
    "50n": UIColor(red: 22.0, green: 33.0, blue: 62.0, alpha: 1.0)
]
