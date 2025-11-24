//
//  RestaurantLocation.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import Foundation

struct RestaurantLocation: Hashable {
    let city: String
    let neighborhood: String
    let phoneNumber: String

    init(city: String = "",
         neighborhood: String = "",
         phoneNumber: String = "")
    {
        self.city = city
        self.neighborhood = neighborhood
        self.phoneNumber = phoneNumber
    }
}
