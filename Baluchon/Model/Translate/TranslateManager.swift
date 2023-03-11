//
//  TranslateManager.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

// MARK: - Translate
class TranslateManager {

    // MARK: - Properties
    var data: Translate? // String
    let translateService = TranslateService.shared
    public weak var delegate: ViewDelegate?

    // MARK: - Methods
    public func getData(textToTranslate: String) {        self.delegate?.toggleActivityIndicator(shown: true)
        translateService.getTranslate(with: textToTranslate) { success, translate in
            self.delegate?.toggleActivityIndicator(shown: false)
            guard let translate = translate, success == true else {
                        self.delegate?.presentAlert(title: "Echec de l'appel",
                                                    message: "Google n'a pas répondu.\nVeuillez réessayer.")
                        return
                    }
            self.data = translate
            self.delegate?.updateView()
        }
    }
}
