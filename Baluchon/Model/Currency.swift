//
//  Currency.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 08/01/2023.
//

import Foundation
// MARK: - 
struct Currency {
    static let list:[(name: String, codeISO: String, symbol: String)] = [
        ("EUR", "EUR", "€"),
        ("GBP", "GBP", "£"),
        ("USD", "USD", "$")
    ]

    static var currentCurrencyCodeISO = "EUR"
}
