//
//  NetworkServices.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

func verifiedKey(accesKey: String) -> String{
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "accesKey") as? String
    
    guard let key = apiKey, !key.isEmpty else {
        return "API key does not exist"
    }
    return "\(key)"
}

// MARK: - Fixer API

class ChangeService {
    // MARK: - Properties
    
    static var shared = ChangeService()
    private init() {}
    private var task: URLSessionDataTask?
    private var changeSession = URLSession(configuration: .default)
     
    // MARK: - Initialization
    
    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }
    
    // MARK: - Functions
// func get(networkConfig: , ){}
    func getChange(callback: @escaping(Bool, ChangeRate?) -> Void) {
        var request = URLRequest(url: URL(string: FixerAPI.url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let apiKey = verifiedKey(accesKey: "API_CHANGE_KEY")
        
        request.addValue("\(apiKey)", forHTTPHeaderField: "apikey")
        
        task?.cancel()
        task = changeSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ChangeRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}

// MARK: - Google translate API

class TranslateService {
    
    // MARK: - Properties
    
    static var shared = TranslateService()
    private init() {}
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    
    // MARK: - Initialization
    
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }
    
    // MARK: - Functions
    
    func getTranslate(callback: @escaping(Bool, String?) -> Void) {
        
        
        var request = URLRequest(url: URL(string: GoogleTranslateAPI.url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        
        
        task?.cancel()
        task = translateSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                callback(true, responseJSON.data.translations[0].translatedText)
            }
        }
        task?.resume()
    }
}

// MARK: - OpenWeather API

class WeatherService {
    
    // MARK: - Properties
    
    static var shared = WeatherService()
    private init() {}
    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)
    
    // MARK: - Initialization
    
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - Functions
    
    func getWeather(callback: @escaping(Bool, Weather?) -> Void) {
        var request = URLRequest(url: URL(string: OpenWeatherAPI.url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        task?.cancel()
        task = weatherSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                    callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
