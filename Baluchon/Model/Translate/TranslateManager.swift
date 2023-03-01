//
//  TranslateManager.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation
// MARK: - Translate

class TranslateManager {
    // MARK: Properties
    var data: String?
    let translateService = TranslateService.shared
    public weak var delegate: ViewDelegate?

    // MARK: Methods
    public func getData(textToTranslate: String) {
        translateService.getTranslate(with: textToTranslate) { success, translatedText in
                    guard let translatedText = translatedText, success == true else {
                        self.delegate?.presentAlert(title: "Echec de l'appel",
                                                    message: "Google n'a pas répondu.\nVeuillez réessayer.")
                        return
                    }
            self.data = translatedText
            self.delegate?.updateView()
        }
    }
}
