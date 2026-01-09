//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/11/25.
//

import SwiftUI

struct MenuItem: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let category: MenuCategory
    let imageName: String
    let isVegetarian: Bool
    let isGlutenFree: Bool
    let spicyLevel: Int
    let ingredients: [Ingredient]
    let ordersCount: Int

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

    var hasDietaryInfo: Bool {
        isVegetarian || isGlutenFree || spicyLevel > 0
    }

    var accessibilityDescription: String {
        var parts = [name, description, formattedPrice]
        if isVegetarian { parts.append("Vegetarian") }
        if isGlutenFree { parts.append("Gluten-free") }
        if spicyLevel > 0 { parts.append("Spicy level \(spicyLevel)") }
        if !ingredients.isEmpty {
            parts.append("Ingredients: \(ingredients.map { $0.rawValue }.joined(separator: ", "))")
        }
        return parts.joined(separator: ", ")
    }

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        price: Double,
        category: MenuCategory,
        imageName: String = "fork.knife",
        isVegetarian: Bool = false,
        isGlutenFree: Bool = false,
        spicyLevel: Int = 0,
        ingredients: [Ingredient] = [],
        ordersCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = max(0, price)
        self.category = category
        self.imageName = imageName
        self.isVegetarian = isVegetarian
        self.isGlutenFree = isGlutenFree
        self.spicyLevel = min(max(0, spicyLevel), 3)
        self.ingredients = ingredients
        self.ordersCount = max(0, ordersCount)
    }
}

extension MenuItem {
    static let sample = MenuItem(
        name: "Greek Salad",
        description: "Fresh vegetables with feta cheese and olives",
        price: 10.99,
        category: .appetizers,
        imageName: "leaf.fill",
        isVegetarian: true,
        isGlutenFree: true
    )
}
