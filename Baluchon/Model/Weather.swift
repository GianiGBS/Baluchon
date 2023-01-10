//
//  Weather.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 30/10/2022.
//

import Foundation
// MARK: -
struct Result: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let name: String
}

// MARK: -
struct Sys: Decodable {
    let country: String
}

// MARK: -
struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: -
struct Main: Decodable {
    let temperature: Int
}

