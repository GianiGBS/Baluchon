//
//  Translate.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 30/10/2022.
//

import Foundation
 // MARK: - 
struct Translate: Decodable {
    let data: Translations
    
    struct Translations: Decodable {
        var translations: [TranslatedText]
        
        struct TranslatedText: Decodable {
            var translatedText: String
        }
    }
}
