//
//  TranslateURL.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

// MARK: - Google translate API

class GoogleTranslateAPI {
    // MARK: - Properties

    private static let endpoint = "https://translation.googleapis.com/language/translate/v2"
    private static var parameter: String {
        return "?source=\(Languages.currentLanguageFromCodeISO)&target=\(Languages.currentLanguageToCodeISO)&format=text"
    }
    private static let accessKey = "&key=\(verifiedKey(accesKey: "API_TRANSLATE_KEY"))&q="
    static var url: String {
        return GoogleTranslateAPI.endpoint + GoogleTranslateAPI.parameter + GoogleTranslateAPI.accessKey
    }
}
