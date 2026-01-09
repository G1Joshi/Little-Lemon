//
//  Model.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

@Observable
class Model {
    let restaurants = [
        RestaurantLocation(
            city: "Las Vegas",
            neighborhood: "Downtown",
            phoneNumber: "(702) 555-9898",
            rating: 4.5
        ),
        RestaurantLocation(
            city: "Los Angeles",
            neighborhood: "North Hollywood",
            phoneNumber: "(213) 555-1453",
            rating: 4.8
        ),
        RestaurantLocation(
            city: "Los Angeles",
            neighborhood: "Venice",
            phoneNumber: "(310) 555-1222",
            rating: 4.6
        ),
        RestaurantLocation(
            city: "Nevada",
            neighborhood: "Reno",
            phoneNumber: "(725) 555-5454",
            rating: 4.3
        ),
        RestaurantLocation(
            city: "San Francisco",
            neighborhood: "North Beach",
            phoneNumber: "(415) 555-1345",
            rating: 4.7
        ),
        RestaurantLocation(
            city: "San Francisco",
            neighborhood: "Union Square",
            phoneNumber: "(415) 555-9813",
            rating: 4.9
        ),
    ]

    let menuItems: [MenuItem] = [
        MenuItem(name: "Bruschetta", description: "Grilled bread with tomatoes, garlic, and basil", price: 8.99, category: .appetizers, imageName: "fork.knife", isVegetarian: true, ingredients: [.garlic, .onion], ordersCount: 154),
        MenuItem(name: "Greek Salad", description: "Fresh vegetables with feta cheese and olives", price: 10.99, category: .appetizers, imageName: "leaf.fill", isVegetarian: true, isGlutenFree: true, ingredients: [.lettuce, .onion, .cheese], ordersCount: 231),
        MenuItem(name: "Stuffed Mushrooms", description: "Mushrooms filled with herbs and cheese", price: 9.99, category: .appetizers, imageName: "circle.fill", isVegetarian: true, ingredients: [.mushroom, .cheese, .garlic], ordersCount: 89),
        MenuItem(name: "Calamari", description: "Crispy fried squid with lemon aioli", price: 12.99, category: .appetizers, imageName: "fish.fill", ingredients: [.lemon], ordersCount: 412),

        MenuItem(name: "Mediterranean Pizza", description: "Topped with olives, feta, and sun-dried tomatoes", price: 16.99, category: .mains, imageName: "circle.hexagongrid.fill", isVegetarian: true, ingredients: [.cheese, .tomatoSauce], ordersCount: 523),
        MenuItem(name: "Grilled Salmon", description: "Atlantic salmon with lemon butter sauce", price: 24.99, category: .mains, imageName: "fish.fill", isGlutenFree: true, ingredients: [.lemon], ordersCount: 342),
        MenuItem(name: "Pasta Primavera", description: "Fresh vegetables with garlic and olive oil", price: 15.99, category: .mains, imageName: "square.grid.2x2.fill", isVegetarian: true, ingredients: [.pasta, .broccoli, .carrot, .garlic], ordersCount: 267),
        MenuItem(name: "Lamb Kebab", description: "Grilled lamb skewers with tzatziki", price: 22.99, category: .mains, imageName: "flame.fill", spicyLevel: 2, ingredients: [.onion], ordersCount: 189),
        MenuItem(name: "Chicken Souvlaki", description: "Marinated chicken with Greek spices", price: 18.99, category: .mains, imageName: "flame.fill", isGlutenFree: true, spicyLevel: 1, ingredients: [.chicken, .lemon], ordersCount: 456),
        MenuItem(name: "Vegetarian Moussaka", description: "Layered eggplant with béchamel sauce", price: 17.99, category: .mains, imageName: "square.stack.3d.down.right.fill", isVegetarian: true, ingredients: [.cheese], ordersCount: 124),

        MenuItem(name: "Baklava", description: "Honey-soaked pastry with nuts", price: 7.99, category: .desserts, imageName: "birthday.cake.fill", ingredients: [.sugar], ordersCount: 678),
        MenuItem(name: "Tiramisu", description: "Classic Italian coffee-flavored dessert", price: 8.99, category: .desserts, imageName: "cup.and.saucer.fill", ingredients: [.coffee, .cream, .sugar], ordersCount: 890),
        MenuItem(name: "Lemon Sorbet", description: "Refreshing citrus dessert", price: 6.99, category: .desserts, imageName: "drop.fill", isVegetarian: true, isGlutenFree: true, ingredients: [.lemon, .sugar, .ice], ordersCount: 345),
        MenuItem(name: "Chocolate Lava Cake", description: "Warm chocolate cake with molten center", price: 9.99, category: .desserts, imageName: "birthday.cake.fill", ingredients: [.chocolate, .sugar], ordersCount: 1204),

        MenuItem(name: "Fresh Lemonade", description: "House-made with mint", price: 4.99, category: .drinks, imageName: "drop.fill", isVegetarian: true, isGlutenFree: true, ingredients: [.lemon, .mint, .sugar, .ice], ordersCount: 954),
        MenuItem(name: "Greek Coffee", description: "Traditional strong coffee", price: 3.99, category: .drinks, imageName: "cup.and.saucer.fill", isVegetarian: true, isGlutenFree: true, ingredients: [.coffee], ordersCount: 742),
        MenuItem(name: "Mediterranean Iced Tea", description: "Herbal tea with citrus", price: 4.49, category: .drinks, imageName: "cup.and.saucer.fill", isVegetarian: true, isGlutenFree: true, ingredients: [.orange, .lemon, .ice], ordersCount: 531),
        MenuItem(name: "Fresh Orange Juice", description: "Freshly squeezed", price: 5.99, category: .drinks, imageName: "drop.fill", isVegetarian: true, isGlutenFree: true, ingredients: [.orange, .ice], ordersCount: 821),
    ]

    var reservation = Reservation()
    var reservationHistory: [Reservation] = []
    var displayingReservationForm = false
    var temporaryReservation = Reservation()
    var followNavitationLink = false
    var displayTabBar = true
    var tabBarChanged = false
    var tabViewSelectedIndex = Int.max {
        didSet {
            tabBarChanged = true
        }
    }

    var favoriteMenuItems: Set<UUID> = []
    var favoriteRestaurants: Set<String> = []

    private let userDefaults = UserDefaults.standard

    private enum Keys {
        static let favoriteMenuItems = "favoriteMenuItems"
        static let favoriteRestaurants = "favoriteRestaurants"
        static let reservationHistory = "reservationHistory"
        static let userName = "userName"
        static let userEmail = "userEmail"
        static let userPhone = "userPhone"
        static let hasSeenWelcome = "hasSeenWelcome"
    }

    init() {
        loadFavorites()
        loadReservationHistory()
    }

    func toggleFavoriteMenuItem(_ id: UUID) {
        if favoriteMenuItems.contains(id) {
            favoriteMenuItems.remove(id)
        } else {
            favoriteMenuItems.insert(id)
        }
        saveFavorites()
    }

    func toggleFavoriteRestaurant(_ restaurant: RestaurantLocation) {
        let key = restaurant.favoriteKey
        if favoriteRestaurants.contains(key) {
            favoriteRestaurants.remove(key)
        } else {
            favoriteRestaurants.insert(key)
        }
        saveFavorites()
    }

    func isFavoriteRestaurant(_ restaurant: RestaurantLocation) -> Bool {
        favoriteRestaurants.contains(restaurant.favoriteKey)
    }

    private func saveFavorites() {
        do {
            let menuData = try JSONEncoder().encode(Array(favoriteMenuItems))
            userDefaults.set(menuData, forKey: Keys.favoriteMenuItems)

            let restaurantData = try JSONEncoder().encode(Array(favoriteRestaurants))
            userDefaults.set(restaurantData, forKey: Keys.favoriteRestaurants)
        } catch {
            print("Error saving favorites: \\(error.localizedDescription)")
        }
    }

    private func loadFavorites() {
        if let data = userDefaults.data(forKey: Keys.favoriteMenuItems) {
            do {
                let decoded = try JSONDecoder().decode([UUID].self, from: data)
                favoriteMenuItems = Set(decoded)
            } catch {
                print("Error loading favorite menu items: \\(error.localizedDescription)")
            }
        }

        if let data = userDefaults.data(forKey: Keys.favoriteRestaurants) {
            do {
                let decoded = try JSONDecoder().decode([String].self, from: data)
                favoriteRestaurants = Set(decoded)
            } catch {
                print("Error loading favorite restaurants: \\(error.localizedDescription)")
            }
        }
    }

    func addReservationToHistory(_ reservation: Reservation) {
        guard reservation.isValid else {
            print("Cannot save invalid reservation")
            return
        }

        reservationHistory.append(reservation)
        saveReservationHistory()
    }

    private func saveReservationHistory() {
        do {
            let encoded = try JSONEncoder().encode(reservationHistory)
            userDefaults.set(encoded, forKey: Keys.reservationHistory)
        } catch {
            print("Error saving reservation history: \\(error.localizedDescription)")
        }
    }

    private func loadReservationHistory() {
        if let data = userDefaults.data(forKey: Keys.reservationHistory) {
            do {
                reservationHistory = try JSONDecoder().decode([Reservation].self, from: data)
            } catch {
                print("Error loading reservation history: \\(error.localizedDescription)")
            }
        }
    }

    func clearAllData() {
        reservationHistory.removeAll()
        favoriteMenuItems.removeAll()
        favoriteRestaurants.removeAll()
        reservation = Reservation()

        let keysToRemove = [
            Keys.reservationHistory,
            Keys.favoriteMenuItems,
            Keys.favoriteRestaurants,
            Keys.userName,
            Keys.userEmail,
            Keys.userPhone,
        ]

        keysToRemove.forEach { userDefaults.removeObject(forKey: $0) }
    }

    var totalFavoritesCount: Int {
        favoriteMenuItems.count + favoriteRestaurants.count
    }

    var hasActiveReservation: Bool {
        !reservation.isEmpty
    }
}
