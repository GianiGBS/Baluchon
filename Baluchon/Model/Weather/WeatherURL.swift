//
//  WeatherURL.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

// MARK: - OpenWeather API
class OpenWeatherAPI {

    // MARK: - Properties
    private static let endpoint = "https://api.openweathermap.org/data/2.5/weather"
    private static var parameter: String {
        return "?lat=\(CurrentLocation.latitude)&lon=\(CurrentLocation.longitude)&units=metric"
    }
    private static let accessKey = "&appid=\(verifiedKey(accesKey: "API_WEATHER_KEY"))"
    static var url: String {
        return OpenWeatherAPI.endpoint + OpenWeatherAPI.parameter + OpenWeatherAPI.accessKey
    }
}
