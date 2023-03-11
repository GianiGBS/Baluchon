//
//  ChangeURL.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

// MARK: - Fixer API

class FixerAPI {

    // MARK: - Properties

    private static let endpoint = "https://api.apilayer.com/fixer/convert"
    private static var parameter: String {
        return "?from=\(Currency.currentCurrencyFromCodeISO)&to=\(Currency.currentCurrencyToCodeISO)&amount="
    }
    static var url: String {
        return FixerAPI.endpoint + FixerAPI.parameter
    }

}
