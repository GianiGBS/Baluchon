//
//  TranslateService.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation
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

    // MARK: - Methods

    func getTranslate(with text: String, callback: @escaping(Bool, String?) -> Void) {

        let encodingText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let allURL = GoogleTranslateAPI.url + encodingText!

        var request = URLRequest(url: URL(string: allURL)!)
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
                print(responseJSON)
                callback(true, responseJSON.data.translations[0].translatedText)
            }
        }
        task?.resume()
    }
}
