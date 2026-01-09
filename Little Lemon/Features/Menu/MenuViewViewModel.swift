//
//  MenuViewViewModel.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

@Observable
class MenuViewViewModel {
    var allMenuItems: [MenuItem]
    var selectedCategories: Set<MenuCategory> = Set(MenuCategory.allCases)
    var selectedSortOption: SortOption = .price

    init() {
        allMenuItems = [
            MenuItem(
                name: "Bruschetta", description: "Grilled bread with tomatoes, garlic, and basil",
                price: 8.99, category: .appetizers, imageName: "fork.knife", isVegetarian: true
            ),
            MenuItem(
                name: "Greek Salad", description: "Fresh vegetables with feta cheese and olives",
                price: 10.99, category: .appetizers, imageName: "leaf.fill", isVegetarian: true,
                isGlutenFree: true
            ),
            MenuItem(
                name: "Stuffed Mushrooms", description: "Mushrooms filled with herbs and cheese",
                price: 9.99, category: .appetizers, imageName: "circle.fill", isVegetarian: true
            ),
            MenuItem(
                name: "Calamari", description: "Crispy fried squid with lemon aioli", price: 12.99,
                category: .appetizers, imageName: "fish.fill"
            ),
            MenuItem(
                name: "Mediterranean Pizza",
                description: "Topped with olives, feta, and sun-dried tomatoes", price: 16.99,
                category: .mains, imageName: "circle.hexagongrid.fill", isVegetarian: true
            ),
            MenuItem(
                name: "Grilled Salmon", description: "Atlantic salmon with lemon butter sauce",
                price: 24.99, category: .mains, imageName: "fish.fill", isGlutenFree: true
            ),
            MenuItem(
                name: "Pasta Primavera", description: "Fresh vegetables with garlic and olive oil",
                price: 15.99, category: .mains, imageName: "square.grid.2x2.fill",
                isVegetarian: true
            ),
            MenuItem(
                name: "Lamb Kebab", description: "Grilled lamb skewers with tzatziki", price: 22.99,
                category: .mains, imageName: "flame.fill", spicyLevel: 2
            ),
            MenuItem(
                name: "Chicken Souvlaki", description: "Marinated chicken with Greek spices",
                price: 18.99, category: .mains, imageName: "flame.fill", isGlutenFree: true,
                spicyLevel: 1
            ),
            MenuItem(
                name: "Baklava", description: "Layered pastry with honey and nuts", price: 7.99,
                category: .desserts, imageName: "birthday.cake.fill"
            ),
            MenuItem(
                name: "Tiramisu", description: "Coffee-flavored Italian dessert", price: 8.99,
                category: .desserts, imageName: "birthday.cake.fill"
            ),
            MenuItem(
                name: "Lemon Sorbet", description: "Refreshing frozen dessert", price: 6.99,
                category: .desserts, imageName: "snowflake", isVegetarian: true, isGlutenFree: true
            ),
            MenuItem(
                name: "Greek Coffee", description: "Traditional strong coffee", price: 3.99,
                category: .drinks, imageName: "cup.and.saucer.fill"
            ),
            MenuItem(
                name: "Lemonade", description: "Fresh-squeezed lemonade", price: 3.49,
                category: .drinks, imageName: "drop.fill", isVegetarian: true, isGlutenFree: true
            ),
            MenuItem(
                name: "Ouzo", description: "Traditional Greek spirit", price: 8.99,
                category: .drinks, imageName: "wineglass"
            ),
        ]
    }

    var filteredMenuItems: [MenuItem] {
        let filtered = allMenuItems.filter { item in
            selectedCategories.contains(item.category)
        }
        return sortItems(filtered)
    }

    private func sortItems(_ items: [MenuItem]) -> [MenuItem] {
        switch selectedSortOption {
        case .price:
            return items.sorted { $0.price < $1.price }
        case .alphabetical:
            return items.sorted { $0.name < $1.name }
        }
    }

    func toggleCategory(_ category: MenuCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    func isCategorySelected(_ category: MenuCategory) -> Bool {
        selectedCategories.contains(category)
    }
}

enum SortOption: String, CaseIterable {
    case price = "Price $-$$$"
    case alphabetical = "A-Z"
}
