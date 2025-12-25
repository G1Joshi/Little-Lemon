//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import Foundation

struct MenuItem: Identifiable, MenuItemProtocol {
    let id: UUID
    var price: Double
    let title: String
    let menuCategory: MenuCategory
    var ordersCount: Int
    var ingredients: [Ingredient]
    let imageName: String
    let description: String

    init(
        id: UUID = UUID(),
        title: String,
        price: Double,
        menuCategory: MenuCategory,
        ordersCount: Int = 0,
        ingredients: [Ingredient],
        imageName: String = "",
        description: String = ""
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.menuCategory = menuCategory
        self.ordersCount = ordersCount
        self.ingredients = ingredients
        self.imageName = imageName
        self.description = description
    }
}
