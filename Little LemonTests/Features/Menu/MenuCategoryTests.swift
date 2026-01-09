//
//  MenuCategoryTests.swift
//  Little LemonTests
//
//  Created by Antigravity on 08/01/26.
//

@testable import Little_Lemon
import XCTest

final class MenuCategoryTests: XCTestCase {
    func testMenuCategoryIcons() {
        XCTAssertEqual(MenuCategory.appetizers.icon, "leaf.fill")
        XCTAssertEqual(MenuCategory.mains.icon, "fork.knife")
        XCTAssertEqual(MenuCategory.desserts.icon, "birthday.cake.fill")
        XCTAssertEqual(MenuCategory.drinks.icon, "cup.and.saucer.fill")
    }
}
