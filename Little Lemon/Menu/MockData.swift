//
//  MockData.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import Foundation

enum MockData {
    static let foodItems: [MenuItem] = [
        MenuItem(
            title: "Grilled Salmon",
            price: 24.99,
            menuCategory: .food,
            ordersCount: 150,
            ingredients: [.lemon, .garlic, .spinach],
            imageName: "fish",
            description: "Fresh Atlantic salmon grilled to perfection with lemon herb butter."
        ),
        MenuItem(
            title: "Pasta Primavera",
            price: 16.99,
            menuCategory: .food,
            ordersCount: 120,
            ingredients: [.pasta, .tomatoSauce, .broccoli, .carrot],
            imageName: "pasta",
            description: "Fresh pasta tossed with seasonal vegetables in a light tomato sauce."
        ),
        MenuItem(
            title: "Chicken Parmesan",
            price: 19.99,
            menuCategory: .food,
            ordersCount: 200,
            ingredients: [.chicken, .cheese, .tomatoSauce],
            imageName: "chicken",
            description: "Breaded chicken breast topped with marinara and melted mozzarella."
        ),
        MenuItem(
            title: "Caesar Salad",
            price: 12.99,
            menuCategory: .food,
            ordersCount: 95,
            ingredients: [.lettuce, .cheese, .garlic],
            imageName: "salad",
            description: "Crisp romaine lettuce with classic Caesar dressing and parmesan."
        ),
        MenuItem(
            title: "Beef Stroganoff",
            price: 22.99,
            menuCategory: .food,
            ordersCount: 85,
            ingredients: [.beef, .mushroom, .cream, .onion],
            imageName: "beef",
            description: "Tender beef strips in a rich mushroom cream sauce over egg noodles."
        ),
        MenuItem(
            title: "Mushroom Risotto",
            price: 18.99,
            menuCategory: .food,
            ordersCount: 110,
            ingredients: [.mushroom, .cheese, .garlic, .onion],
            imageName: "risotto",
            description: "Creamy arborio rice with wild mushrooms and parmesan cheese."
        ),
        MenuItem(
            title: "Spinach Lasagna",
            price: 17.99,
            menuCategory: .food,
            ordersCount: 75,
            ingredients: [.spinach, .pasta, .cheese, .tomatoSauce],
            imageName: "lasagna",
            description: "Layers of pasta, spinach, ricotta, and marinara sauce."
        ),
        MenuItem(
            title: "Grilled Chicken Breast",
            price: 18.99,
            menuCategory: .food,
            ordersCount: 130,
            ingredients: [.chicken, .garlic, .lemon],
            imageName: "grilled_chicken",
            description: "Marinated chicken breast grilled with herbs and lemon."
        ),
        MenuItem(
            title: "Vegetable Stir Fry",
            price: 14.99,
            menuCategory: .food,
            ordersCount: 65,
            ingredients: [.broccoli, .carrot, .mushroom, .onion],
            imageName: "stirfry",
            description: "Fresh vegetables stir-fried in a savory garlic sauce."
        ),
        MenuItem(
            title: "Spaghetti Bolognese",
            price: 16.99,
            menuCategory: .food,
            ordersCount: 180,
            ingredients: [.pasta, .beef, .tomatoSauce, .onion, .garlic],
            imageName: "spaghetti",
            description: "Classic Italian pasta with rich meat sauce."
        ),
        MenuItem(
            title: "Greek Salad",
            price: 13.99,
            menuCategory: .food,
            ordersCount: 90,
            ingredients: [.lettuce, .cheese, .onion],
            imageName: "greek_salad",
            description: "Fresh vegetables with feta cheese and olive oil dressing."
        ),
        MenuItem(
            title: "Creamy Garlic Pasta",
            price: 15.99,
            menuCategory: .food,
            ordersCount: 100,
            ingredients: [.pasta, .garlic, .cream, .cheese],
            imageName: "garlic_pasta",
            description: "Fettuccine in a rich garlic cream sauce with parmesan."
        ),
    ]

    static let drinkItems: [MenuItem] = [
        MenuItem(
            title: "Fresh Lemonade",
            price: 4.99,
            menuCategory: .drink,
            ordersCount: 200,
            ingredients: [.lemon, .sugar, .ice, .mint],
            imageName: "lemonade",
            description: "Freshly squeezed lemons with a hint of mint."
        ),
        MenuItem(
            title: "Iced Coffee",
            price: 5.49,
            menuCategory: .drink,
            ordersCount: 180,
            ingredients: [.coffee, .ice, .milk],
            imageName: "iced_coffee",
            description: "Cold brewed coffee served over ice with your choice of milk."
        ),
        MenuItem(
            title: "Strawberry Smoothie",
            price: 6.99,
            menuCategory: .drink,
            ordersCount: 120,
            ingredients: [.strawberry, .milk, .ice, .vanilla],
            imageName: "smoothie",
            description: "Blended fresh strawberries with vanilla and milk."
        ),
        MenuItem(
            title: "Orange Juice",
            price: 4.49,
            menuCategory: .drink,
            ordersCount: 150,
            ingredients: [.orange, .ice],
            imageName: "orange_juice",
            description: "Freshly squeezed orange juice served chilled."
        ),
        MenuItem(
            title: "Mint Mojito",
            price: 7.99,
            menuCategory: .drink,
            ordersCount: 95,
            ingredients: [.mint, .lime, .sugar, .ice],
            imageName: "mojito",
            description: "Refreshing mint and lime mocktail with soda water."
        ),
        MenuItem(
            title: "Hot Chocolate",
            price: 4.99,
            menuCategory: .drink,
            ordersCount: 85,
            ingredients: [.chocolate, .milk, .cream],
            imageName: "hot_chocolate",
            description: "Rich and creamy hot chocolate topped with whipped cream."
        ),
        MenuItem(
            title: "Vanilla Milkshake",
            price: 6.49,
            menuCategory: .drink,
            ordersCount: 110,
            ingredients: [.vanilla, .milk, .ice, .cream],
            imageName: "milkshake",
            description: "Classic vanilla milkshake with a cherry on top."
        ),
        MenuItem(
            title: "Espresso",
            price: 3.99,
            menuCategory: .drink,
            ordersCount: 160,
            ingredients: [.coffee],
            imageName: "espresso",
            description: "Strong Italian-style espresso shot."
        ),
    ]

    static let dessertItems: [MenuItem] = [
        MenuItem(
            title: "Chocolate Lava Cake",
            price: 8.99,
            menuCategory: .dessert,
            ordersCount: 150,
            ingredients: [.chocolate, .cream, .vanilla],
            imageName: "lava_cake",
            description: "Warm chocolate cake with a molten center, served with vanilla ice cream."
        ),
        MenuItem(
            title: "Tiramisu",
            price: 7.99,
            menuCategory: .dessert,
            ordersCount: 130,
            ingredients: [.coffee, .cream, .chocolate],
            imageName: "tiramisu",
            description: "Classic Italian dessert with espresso-soaked ladyfingers and mascarpone."
        ),
        MenuItem(
            title: "Strawberry Cheesecake",
            price: 8.49,
            menuCategory: .dessert,
            ordersCount: 120,
            ingredients: [.strawberry, .cream, .cheese, .vanilla],
            imageName: "cheesecake",
            description: "Creamy New York-style cheesecake with fresh strawberry topping."
        ),
        MenuItem(
            title: "Lemon Sorbet",
            price: 5.99,
            menuCategory: .dessert,
            ordersCount: 80,
            ingredients: [.lemon, .sugar, .mint],
            imageName: "sorbet",
            description: "Light and refreshing lemon sorbet with fresh mint garnish."
        ),
    ]

    static var allItems: [MenuItem] {
        foodItems + drinkItems + dessertItems
    }
}
