//
//  ChangeManager.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

// MARK: - Change
class ChangeManager {

    // MARK: - Properties
    var data: Change?
    let changeService = ChangeService.shared
    public weak var delegate: ViewDelegate?

    // MARK: - Methods
    public func getData(amountToChange: String) {
        self.delegate?.toggleActivityIndicator(shown: true)
        changeService.getChange(with: amountToChange ) { success, change in
            self.delegate?.toggleActivityIndicator(shown: false)
            guard let change = change, success == true else {
                self.delegate?.presentAlert(title: "Echec de l'appel",
                                            message: "Fixer.API n'a pas répondu.\nVeuillez réessayer.")
                return
            }
            self.data = change
            self.delegate?.updateView()
        }
    }
}
