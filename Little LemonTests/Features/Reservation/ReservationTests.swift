//
//  ReservationTests.swift
//  Little LemonTests
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

@testable import Little_Lemon
import XCTest

final class ReservationTests: XCTestCase {
    func testReservationInitialization() {
        let reservation = Reservation(
            customerName: "  John Doe  ",
            customerEmail: "  JOHN@Examples.com  ",
            customerPhoneNumber: "  123-456-7890  ",
            party: -5,
            specialRequests: "  None  "
        )

        XCTAssertEqual(reservation.customerName, "John Doe")
        XCTAssertEqual(reservation.customerEmail, "john@examples.com")
        XCTAssertEqual(reservation.customerPhoneNumber, "123-456-7890")
        XCTAssertEqual(reservation.party, 1) // Should be clamped to min 1
        XCTAssertEqual(reservation.specialRequests, "None")
    }

    func testReservationValidity() {
        let validReservation = Reservation(
            restaurant: RestaurantLocation(city: "City"),
            customerName: "Name",
            customerEmail: "email",
            customerPhoneNumber: "phone",
            party: 2
        )
        XCTAssertTrue(validReservation.isValid)

        let invalidName = Reservation(
            restaurant: RestaurantLocation(city: "City"),
            customerName: "",
            customerEmail: "email",
            customerPhoneNumber: "phone"
        )
        XCTAssertFalse(invalidName.isValid)
    }

    func testReservationIsEmpty() {
        let emptyReservation = Reservation()
        XCTAssertTrue(emptyReservation.isEmpty)

        let nonEmptyReservation = Reservation(restaurant: RestaurantLocation(city: "City"))
        XCTAssertFalse(nonEmptyReservation.isEmpty)
    }
}
