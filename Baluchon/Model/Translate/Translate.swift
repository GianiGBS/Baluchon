//
//  Translate.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 30/10/2022.
//
// swiftlint:disable nesting
import Foundation

 // MARK: - Translate
struct Translate: Decodable {
    let data: Translations

    // MARK: - Translations
    struct Translations: Decodable {
        var translations: [TranslatedText]

        // MARK: - TranslatedText
        struct TranslatedText: Decodable {
            var translatedText: String
        }
    }
}
