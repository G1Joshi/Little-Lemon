//
//  MenuViewViewModel.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

internal import Combine
import Foundation

class MenuViewViewModel: ObservableObject {
    @Published var foodMenuItems: [MenuItem]
    @Published var drinkMenuItems: [MenuItem]
    @Published var dessertMenuItems: [MenuItem]
    @Published var selectedCategories: Set<MenuCategory> = Set(MenuCategory.allCases)
    @Published var selectedSortOption: SortOption = .mostPopular

    init() {
        self.foodMenuItems = MockData.foodItems
        self.drinkMenuItems = MockData.drinkItems
        self.dessertMenuItems = MockData.dessertItems
    }

    var sortedFoodItems: [MenuItem] {
        sortItems(foodMenuItems)
    }

    var sortedDrinkItems: [MenuItem] {
        sortItems(drinkMenuItems)
    }

    var sortedDessertItems: [MenuItem] {
        sortItems(dessertMenuItems)
    }

    var filteredMenuItems: [MenuItem] {
        var items: [MenuItem] = []

        if selectedCategories.contains(.food) {
            items.append(contentsOf: foodMenuItems)
        }
        if selectedCategories.contains(.drink) {
            items.append(contentsOf: drinkMenuItems)
        }
        if selectedCategories.contains(.dessert) {
            items.append(contentsOf: dessertMenuItems)
        }

        return sortItems(items)
    }

    private func sortItems(_ items: [MenuItem]) -> [MenuItem] {
        switch selectedSortOption {
        case .mostPopular:
            return items.sorted { $0.ordersCount > $1.ordersCount }
        case .price:
            return items.sorted { $0.price < $1.price }
        case .alphabetical:
            return items.sorted { $0.title < $1.title }
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
    case mostPopular = "Most Popular"
    case price = "Price $-$$$"
    case alphabetical = "A-Z"
}
