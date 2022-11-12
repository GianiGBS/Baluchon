//
//  NetworkServices.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import Foundation
// MARK: - Fixer API

class ChangeService {
    // MARK: - Properties
    
    static var shared = ChangeService()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var changeSession = URLSession(configuration: .default)
    
    private static let changeURL = URL(string: "https://api.apilayer.com/fixer/latest")!
    
    // MARK: - Initialization
    
    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }
    
    // MARK: - Functions
    
    func getChange(callback: @escaping(Bool, String?)-> Void) {
        var request = URLRequest(url: ChangeService.changeURL)
        request.httpMethod = "HTTPMethod.get.rawValue"
    }
}
// MARK: - Google translate API

class TranslateService {
    // MARK: - Properties
    
    static var shared = TranslateService()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    
    private static let translateURL = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    // MARK: - Initialization
    
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }
    // MARK: - Functions
    
    func getTranslate(callback: @escaping(Bool, String?)-> Void) {
        var request = URLRequest(url: TranslateService.translateURL)
        request.httpMethod = "HTTPMethod.post.rawValue"
    }
}
// MARK: - OpenWeather API

class WeatherService {
    // MARK: - Properties
    
    static var shared = WeatherService()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)
    
    private static let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    
    
    // MARK: - Initialization
    
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    // MARK: - Functions
    
    func getWeather(callback: @escaping(Bool, String?)-> Void) {
        
        var request = URLRequest(url: WeatherService.weatherURL)
        request.httpMethod = "HTTPMethod.get.rawValue"
    }
}
