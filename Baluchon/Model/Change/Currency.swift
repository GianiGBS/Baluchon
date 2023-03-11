//
//  Currency.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 08/01/2023.
//
// swiftlint:disable large_tuple

import Foundation

// MARK: - Currency list
struct Currency {
    static let list:[(name: String, codeISO: String, symbol: String)] = [
        ("Euro", "EUR", "€"),
        ("Livre", "GBP", "£"),
        ("Dollar US", "USD", "$")
    ]

    static var currentCurrencyFromCodeISO = "EUR"
    static var currentCurrencyToCodeISO = "USD"
}
