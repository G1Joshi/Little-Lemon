//
//  RestaurantView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct RestaurantView: View {
    private let restaurant: RestaurantLocation
    private let showRating: Bool

    init(_ restaurant: RestaurantLocation, showRating: Bool = false) {
        self.restaurant = restaurant
        self.showRating = showRating
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(restaurant.city)
                .font(.title2)
                .fontWeight(.semibold)
                .accessibilityAddTraits(.isHeader)

            HStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundColor(LittleLemonTheme.primaryGreen)
                Text(restaurant.neighborhood)
                Text("·")
                Text(restaurant.phoneNumber)
            }
            .font(.caption)
            .foregroundColor(.gray)

            if showRating && restaurant.rating > 0 {
                HStack(spacing: 3) {
                    ForEach(0 ..< 5) { index in
                        Image(systemName: index < Int(restaurant.rating) ? "star.fill" : "star")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                    Text(String(format: "%.1f", restaurant.rating))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Rating \(restaurant.rating) out of 5 stars")
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack(spacing: 20) {
        RestaurantView(
            RestaurantLocation(
                city: "Las Vegas",
                neighborhood: "Downtown",
                phoneNumber: "(702) 555-9898",
                rating: 4.5
            ),
            showRating: true
        )

        RestaurantView(
            RestaurantLocation(
                city: "San Francisco",
                neighborhood: "Union Square",
                phoneNumber: "(415) 555-9813",
                rating: 4.9
            )
        )
    }
    .padding()
}
