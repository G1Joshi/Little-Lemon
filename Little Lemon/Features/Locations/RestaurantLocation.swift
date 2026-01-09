//
//  RestaurantLocation.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct RestaurantLocation: Hashable, Codable {
    let city: String
    let neighborhood: String
    let phoneNumber: String
    let rating: Double

    var fullLocation: String {
        "\(city) - \(neighborhood)"
    }

    var favoriteKey: String {
        "\(city)-\(neighborhood)"
    }

    var isValid: Bool {
        !city.isEmpty && !neighborhood.isEmpty && !phoneNumber.isEmpty
    }

    var starRating: Int {
        Int(rating.rounded())
    }

    init(
        city: String = "",
        neighborhood: String = "",
        phoneNumber: String = "",
        rating: Double = 0.0
    ) {
        self.city = city.trimmingCharacters(in: .whitespaces)
        self.neighborhood = neighborhood.trimmingCharacters(in: .whitespaces)
        self.phoneNumber = phoneNumber.trimmingCharacters(in: .whitespaces)
        self.rating = min(max(0, rating), 5.0)
    }
}

extension RestaurantLocation {
    static let sample = RestaurantLocation(
        city: "San Francisco",
        neighborhood: "Union Square",
        phoneNumber: "(415) 555-9813",
        rating: 4.9
    )
}
