//
//  URLServices.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 25/11/2022.
//

import Foundation


// MARK: - Fixer API
class FixerAPI {
    // MARK: - Properties
    private static let endpoint = "https://api.apilayer.com/fixer/convert"
    private static var parameter : String {
        return "?from=\(Currency.currentCurrencyCodeISO)&to=\(Currency.currentCurrencyCodeISO)&amount="
    }
    static var url : String {
        return FixerAPI.endpoint + FixerAPI.parameter
    }
    
}

// MARK: - Google translate API
class GoogleTranslateAPI {
    // MARK: - Properties
    private static let endpoint = "https://translation.googleapis.com/language/translate/v2"
    private static var parameter : String {
        return "?source=\(Languages.currentLanguageCodeISO)&target=\(Languages.currentLanguageCodeISO)&format=text&q="
    }
    private static let accessKey = "&key=\(verifiedKey(accesKey: "API_TRANSLATE_KEY"))"
    static var url : String {
        return GoogleTranslateAPI.endpoint + GoogleTranslateAPI.parameter + GoogleTranslateAPI.accessKey
    }
}
// MARK: - OpenWeather API
class OpenWeatherAPI {
    // MARK: - Properties
    private static let endpoint = "https://api.openweathermap.org/data/2.5/weather"
    private static var parameter : String {
        return "?lat=\(Int.self)&lon=\(Int.self)"
    }
    private static let accessKey = "&appid=\(verifiedKey(accesKey: "API_WEATHER_KEY"))"
    static var url : String {
        return OpenWeatherAPI.endpoint + OpenWeatherAPI.parameter + OpenWeatherAPI.accessKey
    }
}
