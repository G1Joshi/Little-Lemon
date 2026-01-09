//
//  MenuViewViewModelTests.swift
//  Little LemonTests
//
//  Created by Antigravity on 08/01/26.
//

@testable import Little_Lemon
import XCTest

final class MenuViewViewModelTests: XCTestCase {
    var viewModel: MenuViewViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MenuViewViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertFalse(viewModel.allMenuItems.isEmpty)
        XCTAssertEqual(viewModel.selectedCategories.count, MenuCategory.allCases.count)
        XCTAssertEqual(viewModel.selectedSortOption, .price)
    }

    func testCategoryToggling() {
        let category = MenuCategory.appetizers
        XCTAssertTrue(viewModel.isCategorySelected(category))

        viewModel.toggleCategory(category)
        XCTAssertFalse(viewModel.isCategorySelected(category))
        XCTAssertFalse(viewModel.filteredMenuItems.contains { $0.category == category })

        viewModel.toggleCategory(category)
        XCTAssertTrue(viewModel.isCategorySelected(category))
        XCTAssertTrue(viewModel.filteredMenuItems.contains { $0.category == category })
    }

    func testFiltering() {
        for category in MenuCategory.allCases {
            viewModel.selectedCategories.remove(category)
        }
        XCTAssertTrue(viewModel.filteredMenuItems.isEmpty)

        viewModel.toggleCategory(.desserts)
        XCTAssertTrue(viewModel.filteredMenuItems.allSatisfy { $0.category == .desserts })
    }

    func testSortingByPrice() {
        viewModel.selectedSortOption = .price
        let items = viewModel.filteredMenuItems

        for i in 0 ..< (items.count - 1) {
            XCTAssertLessThanOrEqual(items[i].price, items[i + 1].price)
        }
    }

    func testSortingAlphabetically() {
        viewModel.selectedSortOption = .alphabetical
        let items = viewModel.filteredMenuItems

        for i in 0 ..< (items.count - 1) {
            XCTAssertLessThanOrEqual(items[i].name, items[i + 1].name)
        }
    }
}
