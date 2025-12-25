//
//  MenuItemProtocol.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import Foundation

protocol MenuItemProtocol {
    var id: UUID { get }
    var price: Double { get set }
    var title: String { get }
    var menuCategory: MenuCategory { get }
    var ordersCount: Int { get set }
    var ingredients: [Ingredient] { get set }
}
