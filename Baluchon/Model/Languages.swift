//
//  Languages.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 21/11/2022.
//

import Foundation
// MARK: - Languages list
struct Languages {
    static let list:[(name: String, codeISO: String)] = [
        ("Anglais", "en"),
        ("Allemand", "de"),
        ("Espagnol", "es"),
        ("Français", "fr"),
        ("Italien", "it")
    ]

    static var currentLanguageFromCodeISO = "fr"
    static var currentLanguageToCodeISO = "en"
}
