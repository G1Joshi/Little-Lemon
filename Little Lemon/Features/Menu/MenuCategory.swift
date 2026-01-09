//
//  MenuCategory.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

enum MenuCategory: String, CaseIterable, Codable {
    case appetizers = "Appetizers"
    case mains = "Mains"
    case desserts = "Desserts"
    case drinks = "Drinks"

    var icon: String {
        switch self {
        case .appetizers: return "leaf.fill"
        case .mains: return "fork.knife"
        case .desserts: return "birthday.cake.fill"
        case .drinks: return "cup.and.saucer.fill"
        }
    }
}
