//
//  MenuItemTests.swift
//  Little LemonTests
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import XCTest

@testable import Little_Lemon

final class MenuItemTests: XCTestCase {
    func testMenuItemTitle() {
        let expectedTitle = "Grilled Salmon"

        let menuItem = MenuItem(
            title: expectedTitle,
            price: 24.99,
            menuCategory: .food,
            ingredients: [.lemon, .garlic]
        )

        XCTAssertEqual(
            menuItem.title, expectedTitle, "Menu item title should equal the initialized value"
        )
    }

    func testMenuItemIngredients() {
        let expectedIngredients: [Ingredient] = [.pasta, .tomatoSauce, .cheese]

        let menuItem = MenuItem(
            title: "Pasta Primavera",
            price: 16.99,
            menuCategory: .food,
            ingredients: expectedIngredients
        )

        XCTAssertEqual(
            menuItem.ingredients, expectedIngredients,
            "Menu item ingredients should equal the initialized value"
        )
    }

    func testMenuItemPrice() {
        let expectedPrice = 19.99

        let menuItem = MenuItem(
            title: "Chicken Parmesan",
            price: expectedPrice,
            menuCategory: .food,
            ingredients: [.chicken, .cheese]
        )

        XCTAssertEqual(
            menuItem.price, expectedPrice, accuracy: 0.01,
            "Menu item price should equal the initialized value"
        )
    }

    func testMenuItemCategory() {
        let expectedCategory = MenuCategory.drink

        let menuItem = MenuItem(
            title: "Fresh Lemonade",
            price: 4.99,
            menuCategory: expectedCategory,
            ingredients: [.lemon, .sugar]
        )

        XCTAssertEqual(
            menuItem.menuCategory, expectedCategory,
            "Menu item category should equal the initialized value"
        )
    }

    func testMenuItemOrdersCount() {
        let expectedOrdersCount = 100

        let menuItem = MenuItem(
            title: "Tiramisu",
            price: 7.99,
            menuCategory: .dessert,
            ordersCount: expectedOrdersCount,
            ingredients: [.coffee, .cream]
        )

        XCTAssertEqual(
            menuItem.ordersCount, expectedOrdersCount,
            "Menu item orders count should equal the initialized value"
        )
    }

    func testMenuItemHasUniqueId() {
        let menuItem1 = MenuItem(
            title: "Item 1",
            price: 10.99,
            menuCategory: .food,
            ingredients: [.chicken]
        )

        let menuItem2 = MenuItem(
            title: "Item 2",
            price: 12.99,
            menuCategory: .food,
            ingredients: [.beef]
        )

        XCTAssertNotEqual(menuItem1.id, menuItem2.id, "Each menu item should have a unique ID")
    }

    func testMenuItemDefaultOrdersCount() {
        let menuItem = MenuItem(
            title: "New Item",
            price: 15.99,
            menuCategory: .food,
            ingredients: [.spinach]
        )

        XCTAssertEqual(menuItem.ordersCount, 0, "Default orders count should be 0")
    }
}
