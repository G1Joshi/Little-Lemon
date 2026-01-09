//
//  RestaurantLocationTests.swift
//  Little LemonTests
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

@testable import Little_Lemon
import XCTest

final class RestaurantLocationTests: XCTestCase {
    func testRestaurantLocationInitialization() {
        let restaurant = RestaurantLocation(
            city: "  New York  ",
            neighborhood: "  Manhattan  ",
            phoneNumber: "  123-456-7890  ",
            rating: 4.5
        )

        XCTAssertEqual(restaurant.city, "New York")
        XCTAssertEqual(restaurant.neighborhood, "Manhattan")
        XCTAssertEqual(restaurant.phoneNumber, "123-456-7890")
        XCTAssertEqual(restaurant.rating, 4.5)
    }

    func testRestaurantLocationFullLocation() {
        let restaurant = RestaurantLocation(city: "New York", neighborhood: "Manhattan")
        XCTAssertEqual(restaurant.fullLocation, "New York - Manhattan")
    }

    func testRestaurantLocationFavoriteKey() {
        let restaurant = RestaurantLocation(city: "New York", neighborhood: "Manhattan")
        XCTAssertEqual(restaurant.favoriteKey, "New York-Manhattan")
    }

    func testRestaurantLocationValidity() {
        let validRestaurant = RestaurantLocation(city: "City", neighborhood: "Hood", phoneNumber: "123")
        XCTAssertTrue(validRestaurant.isValid)

        let invalidCity = RestaurantLocation(city: "", neighborhood: "Hood", phoneNumber: "123")
        XCTAssertFalse(invalidCity.isValid)

        let invalidNeighborhood = RestaurantLocation(city: "City", neighborhood: "", phoneNumber: "123")
        XCTAssertFalse(invalidNeighborhood.isValid)

        let invalidPhone = RestaurantLocation(city: "City", neighborhood: "Hood", phoneNumber: "")
        XCTAssertFalse(invalidPhone.isValid)
    }

    func testRestaurantLocationRatingClamping() {
        let highRating = RestaurantLocation(rating: 6.0)
        XCTAssertEqual(highRating.rating, 5.0)

        let lowRating = RestaurantLocation(rating: -1.0)
        XCTAssertEqual(lowRating.rating, 0.0)
    }

    func testRestaurantLocationStarRating() {
        let restaurant1 = RestaurantLocation(rating: 4.7)
        XCTAssertEqual(restaurant1.starRating, 5)

        let restaurant2 = RestaurantLocation(rating: 4.3)
        XCTAssertEqual(restaurant2.starRating, 4)
    }
}
