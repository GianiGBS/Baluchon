//
//  Change.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 30/10/2022.
//

import Foundation
// MARK: - ChangeRate
struct ChangeRate: Decodable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: Rates
}

// MARK: - Rates
struct Rates: Decodable {
    let usd: Decimal
}
