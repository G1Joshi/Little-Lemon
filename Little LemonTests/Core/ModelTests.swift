//
//  ModelTests.swift
//  Little LemonTests
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

@testable import Little_Lemon
import XCTest

final class ModelTests: XCTestCase {
    var model: Model!

    override func setUp() {
        super.setUp()
        model = Model()
        model.clearAllData()
    }

    override func tearDown() {
        model.clearAllData()
        model = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertFalse(model.menuItems.isEmpty)
        XCTAssertFalse(model.restaurants.isEmpty)
        XCTAssertTrue(model.favoriteMenuItems.isEmpty)
        XCTAssertTrue(model.favoriteRestaurants.isEmpty)
        XCTAssertTrue(model.reservationHistory.isEmpty)
    }

    func testToggleFavoriteMenuItem() {
        guard let item = model.menuItems.first else {
            XCTFail("No menu items found")
            return
        }

        model.toggleFavoriteMenuItem(item.id)
        XCTAssertTrue(model.favoriteMenuItems.contains(item.id))

        model.toggleFavoriteMenuItem(item.id)
        XCTAssertFalse(model.favoriteMenuItems.contains(item.id))
    }

    func testToggleFavoriteRestaurant() {
        guard let restaurant = model.restaurants.first else {
            XCTFail("No restaurants found")
            return
        }

        model.toggleFavoriteRestaurant(restaurant)
        XCTAssertTrue(model.favoriteRestaurants.contains(restaurant.favoriteKey))

        model.toggleFavoriteRestaurant(restaurant)
        XCTAssertFalse(model.favoriteRestaurants.contains(restaurant.favoriteKey))
    }

    func testAddReservationToHistory() {
        let reservation = Reservation(
            restaurant: RestaurantLocation(city: "City"),
            customerName: "Name",
            customerEmail: "email",
            customerPhoneNumber: "phone",
            party: 2
        )

        model.addReservationToHistory(reservation)
        XCTAssertEqual(model.reservationHistory.count, 1)
        XCTAssertEqual(model.reservationHistory.first?.id, reservation.id)
    }

    func testClearAllData() {
        let item = model.menuItems.first!
        model.toggleFavoriteMenuItem(item.id)

        let reservation = Reservation(
            restaurant: RestaurantLocation(city: "City"),
            customerName: "Name",
            customerEmail: "email",
            customerPhoneNumber: "phone",
            party: 2
        )
        model.addReservationToHistory(reservation)

        XCTAssertFalse(model.favoriteMenuItems.isEmpty)
        XCTAssertFalse(model.reservationHistory.isEmpty)

        model.clearAllData()

        XCTAssertTrue(model.favoriteMenuItems.isEmpty)
        XCTAssertTrue(model.reservationHistory.isEmpty)
        XCTAssertTrue(model.favoriteRestaurants.isEmpty)
        XCTAssertTrue(model.reservation.isEmpty)
    }
}
