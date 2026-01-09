//
//  LocationsView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct LocationsView: View {
    @Environment(Model.self) var model

    @State private var searchText = ""
    @State private var showFavoritesOnly = false

    var filteredRestaurants: [RestaurantLocation] {
        var restaurants = model.restaurants

        if showFavoritesOnly {
            restaurants = restaurants.filter { model.isFavoriteRestaurant($0) }
        }

        if !searchText.isEmpty {
            restaurants = restaurants.filter {
                $0.city.localizedCaseInsensitiveContains(searchText)
                    || $0.neighborhood.localizedCaseInsensitiveContains(searchText)
            }
        }

        return restaurants.sorted { $0.rating > $1.rating }
    }

    private var titleText: String {
        model.displayingReservationForm ? "Reservation Details" : "Select a location"
    }

    var body: some View {
        VStack(spacing: 0) {
            LittleLemonBanner(size: 80)
                .padding(20)

            Text(titleText)
                .font(LittleLemonTheme.headingFont(18))
                .padding([.leading, .trailing], 24)
                .padding([.top, .bottom], 8)
                .background(LittleLemonTheme.primaryGreen.opacity(0.1))
                .foregroundColor(LittleLemonTheme.primaryGreen)
                .cornerRadius(LittleLemonTheme.CornerRadius.large)
                .padding(.bottom, 10)

            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search locations...", text: $searchText)
                        .textFieldStyle(.plain)
                        .autocapitalization(.none)

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(10)
                .background(LittleLemonTheme.cloud)
                .cornerRadius(LittleLemonTheme.CornerRadius.medium)

                Button(action: {
                    withAnimation(.spring()) {
                        showFavoritesOnly.toggle()
                    }
                }) {
                    Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                        .foregroundColor(showFavoritesOnly ? .red : .gray)
                        .padding(10)
                        .background(LittleLemonTheme.cloud)
                        .cornerRadius(LittleLemonTheme.CornerRadius.medium)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)

            NavigationView {
                if filteredRestaurants.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No restaurants found")
                            .font(.headline)
                            .foregroundColor(.gray)
                        if showFavoritesOnly {
                            Text("Try adding some favorites")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(filteredRestaurants, id: \.self) { restaurant in
                        NavigationLink {
                            ReservationForm(restaurant)
                        } label: {
                            EnhancedRestaurantRow(restaurant: restaurant)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .cardStyle()
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
        }
        .padding(.top, -10)
    }
}

struct EnhancedRestaurantRow: View {
    @Environment(Model.self) var model
    let restaurant: RestaurantLocation

    var isFavorite: Bool {
        model.isFavoriteRestaurant(restaurant)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(restaurant.city)
                    .font(.title3)
                    .fontWeight(.semibold)

                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.caption)
                        .foregroundColor(LittleLemonTheme.primaryGreen)
                    Text(restaurant.neighborhood)
                        .font(LittleLemonTheme.bodyFont(14))
                        .foregroundColor(.gray)
                }

                HStack(spacing: 4) {
                    Image(systemName: "phone.fill")
                        .font(.caption)
                        .foregroundColor(LittleLemonTheme.primaryGreen)
                    Text(restaurant.phoneNumber)
                        .font(LittleLemonTheme.bodyFont(12))
                        .foregroundColor(.gray)
                }

                HStack(spacing: 3) {
                    ForEach(0 ..< 5) { index in
                        Image(systemName: index < Int(restaurant.rating) ? "star.fill" : "star")
                            .font(.caption2)
                            .foregroundColor(LittleLemonTheme.primaryYellow)
                    }
                    Text(String(format: "%.1f", restaurant.rating))
                        .font(LittleLemonTheme.bodyFont(12))
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Button(action: {
                withAnimation(.spring(response: 0.3)) {
                    model.toggleFavoriteRestaurant(restaurant)
                }
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    LocationsView()
        .environment(Model())
}
