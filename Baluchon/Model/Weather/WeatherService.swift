//
//  WeatherService.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

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

    // MARK: - Methods
    func getWeather(callback: @escaping(Bool, Ephemeride?) -> Void) {

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
                guard let responseJSON = try? JSONDecoder().decode(Ephemeride.self, from: data) else {
                    callback(false, nil)
                    return
                }
                print(responseJSON)
                let ephemeride = responseJSON
                callback(true, ephemeride)
            }
        }
        task?.resume()
    }
}
