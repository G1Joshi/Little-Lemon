//
//  Reservation.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct Reservation: Codable, Identifiable {
    var id = UUID()
    var restaurant: RestaurantLocation
    var customerName: String
    var customerEmail: String
    var customerPhoneNumber: String
    var reservationDate: Date
    var party: Int
    var specialRequests: String

    var isValid: Bool {
        !restaurant.city.isEmpty &&
            !customerName.isEmpty &&
            !customerEmail.isEmpty &&
            !customerPhoneNumber.isEmpty &&
            party > 0
    }

    var isFuture: Bool {
        reservationDate > Date()
    }

    var isEmpty: Bool {
        restaurant.city.isEmpty
    }

    var formattedDate: String {
        reservationDate.formatted(date: .abbreviated, time: .shortened)
    }

    init(restaurant: RestaurantLocation = RestaurantLocation(),
         customerName: String = "",
         customerEmail: String = "",
         customerPhoneNumber: String = "",
         reservationDate: Date = Date(),
         party: Int = 1,
         specialRequests: String = "")
    {
        self.restaurant = restaurant
        self.customerName = customerName.trimmingCharacters(in: .whitespaces)
        self.customerEmail = customerEmail.trimmingCharacters(in: .whitespaces).lowercased()
        self.customerPhoneNumber = customerPhoneNumber.trimmingCharacters(in: .whitespaces)
        self.reservationDate = reservationDate
        self.party = max(1, party)
        self.specialRequests = specialRequests.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Reservation {
    static let sample = Reservation(
        restaurant: RestaurantLocation(
            city: "San Francisco",
            neighborhood: "Union Square",
            phoneNumber: "(415) 555-9813",
            rating: 4.9
        ),
        customerName: "John Doe",
        customerEmail: "john@example.com",
        customerPhoneNumber: "(555) 123-4567",
        reservationDate: Date().addingTimeInterval(86400),
        party: 4,
        specialRequests: "Window seat preferred"
    )
}
