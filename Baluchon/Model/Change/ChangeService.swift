//
//  ChangeService.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

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

    // MARK: - Methods
    func getChange(with amount: String, callback: @escaping(Bool, Change?) -> Void) {

        let allURL = FixerAPI.url + amount

        var request = URLRequest(url: URL(string: allURL)!)
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
                guard let responseJSON = try? JSONDecoder().decode(Change.self, from: data) else {
                    callback(false, nil)
                    return
                }
                print(responseJSON)
                let change = responseJSON
                callback(true, change)
            }
        }
        task?.resume()
    }
}
