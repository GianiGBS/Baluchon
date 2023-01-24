//
//  Change.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 30/10/2022.
//

import Foundation
// MARK: - ChangeRate
struct Change: Decodable {
    let success: Bool
    let query: Query
    let info: Info
    let date: String
    let result: Double
}

// MARK: - Query
struct Query: Decodable {
    let from: String
    let to : String
    let amount : Double
}

// MARK: - Info
struct Info: Decodable {
    let rate: Double
}


