//
//  MenuItemTests.swift
//  Little LemonTests
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

@testable import Little_Lemon
import XCTest

final class MenuItemTests: XCTestCase {
    func testMenuItemName() {
        let expectedName = "Grilled Salmon"
        let menuItem = MenuItem(
            name: expectedName,
            description: "Fresh salmon",
            price: 24.99,
            category: .mains
        )

        XCTAssertEqual(menuItem.name, expectedName, "Menu item name should equal the initialized value")
    }

    func testMenuItemPrice() {
        let expectedPrice = 19.99
        let menuItem = MenuItem(
            name: "Chicken Parmesan",
            description: "Classic chicken",
            price: expectedPrice,
            category: .mains
        )

        XCTAssertEqual(menuItem.price, expectedPrice, accuracy: 0.01, "Menu item price should equal the initialized value")
    }

    func testMenuItemPriceValidation() {
        let menuItem = MenuItem(
            name: "Negative Price",
            description: "Testing negative price",
            price: -10.0,
            category: .mains
        )
        XCTAssertEqual(menuItem.price, 0.0, "Negative price should be clamped to 0")
    }

    func testMenuItemCategory() {
        let expectedCategory = MenuCategory.drinks
        let menuItem = MenuItem(
            name: "Fresh Lemonade",
            description: "Sweet and sour",
            price: 4.99,
            category: expectedCategory
        )

        XCTAssertEqual(menuItem.category, expectedCategory, "Menu item category should equal the initialized value")
    }

    func testMenuItemFormattedPrice() {
        let menuItem = MenuItem(
            name: "Item",
            description: "Desc",
            price: 10.99,
            category: .mains
        )
        XCTAssertEqual(menuItem.formattedPrice, "$10.99", "Formatted price should include dollar sign and 2 decimal places")
    }

    func testMenuItemHasDietaryInfo() {
        let vegItem = MenuItem(name: "Veg", description: "D", price: 5, category: .mains, isVegetarian: true)
        let gfItem = MenuItem(name: "GF", description: "D", price: 5, category: .mains, isGlutenFree: true)
        let spicyItem = MenuItem(name: "Spicy", description: "D", price: 5, category: .mains, spicyLevel: 1)
        let plainItem = MenuItem(name: "Plain", description: "D", price: 5, category: .mains)

        XCTAssertTrue(vegItem.hasDietaryInfo)
        XCTAssertTrue(gfItem.hasDietaryInfo)
        XCTAssertTrue(spicyItem.hasDietaryInfo)
        XCTAssertFalse(plainItem.hasDietaryInfo)
    }

    func testMenuItemSpicyLevelClamping() {
        let highSpicy = MenuItem(name: "Hot", description: "D", price: 5, category: .mains, spicyLevel: 5)
        let lowSpicy = MenuItem(name: "Mild", description: "D", price: 5, category: .mains, spicyLevel: -1)

        XCTAssertEqual(highSpicy.spicyLevel, 3, "Spicy level should be clamped to max 3")
        XCTAssertEqual(lowSpicy.spicyLevel, 0, "Spicy level should be clamped to min 0")
    }

    func testMenuItemAccessibilityDescription() {
        let menuItem = MenuItem(
            name: "Greek Salad",
            description: "Fresh veggies",
            price: 10.99,
            category: .appetizers,
            isVegetarian: true,
            isGlutenFree: true,
            spicyLevel: 1
        )

        let expected = "Greek Salad, Fresh veggies, $10.99, Vegetarian, Gluten-free, Spicy level 1"
        XCTAssertEqual(menuItem.accessibilityDescription, expected)
    }

    func testMenuItemHasUniqueId() {
        let menuItem1 = MenuItem(name: "Item 1", description: "D", price: 10, category: .mains)
        let menuItem2 = MenuItem(name: "Item 2", description: "D", price: 12, category: .mains)

        XCTAssertNotEqual(menuItem1.id, menuItem2.id, "Each menu item should have a unique ID")
    }
}
