//
//  MenuItemDetailsView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

struct MenuItemDetailsView: View {
    let menuItem: MenuItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: LittleLemonTheme.CornerRadius.large)
                        .fill(categoryColor.opacity(0.2))
                        .frame(height: 200)

                    Image(systemName: categoryIcon)
                        .font(.system(size: 80))
                        .foregroundColor(categoryColor)
                }
                .padding(.horizontal)
                .shimmer()

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Spacer()

                        VStack(spacing: 4) {
                            Text(menuItem.name)
                                .font(.title)
                                .fontWeight(.bold)

                            Image(systemName: menuItem.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .foregroundColor(categoryColor.opacity(0.8))
                                .padding(.horizontal, 40)

                            HStack {
                                Image(systemName: categoryIcon)
                                    .foregroundColor(categoryColor)
                                Text(menuItem.category.rawValue)
                                    .foregroundColor(.secondary)
                            }
                            .font(.subheadline)

                            Text(menuItem.formattedPrice)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(categoryColor)
                        }

                        Spacer()
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .font(LittleLemonTheme.headingFont(18))

                        Text(menuItem.description)
                            .font(LittleLemonTheme.bodyFont())
                            .foregroundColor(.secondary)
                    }

                    if !menuItem.ingredients.isEmpty {
                        Divider()
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Ingredients")
                                .font(LittleLemonTheme.headingFont(18))

                            Text(menuItem.ingredients.map { $0.rawValue }.joined(separator: ", "))
                                .font(LittleLemonTheme.bodyFont())
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Orders Count")
                                .font(LittleLemonTheme.headingFont(18))
                            Text("\(menuItem.ordersCount) orders served")
                                .font(LittleLemonTheme.bodyFont(14))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Dietary Information")
                            .font(.headline)

                        HStack(spacing: 12) {
                            if menuItem.isVegetarian {
                                DietaryBadge(icon: "leaf.fill", text: "Vegetarian", color: .green)
                            }
                            if menuItem.isGlutenFree {
                                DietaryBadge(
                                    icon: "g.circle.fill", text: "Gluten Free", color: .orange
                                )
                            }
                            if menuItem.spicyLevel > 0 {
                                DietaryBadge(
                                    icon: "flame.fill", text: "Spicy Level \(menuItem.spicyLevel)",
                                    color: .red
                                )
                            }
                        }

                        if !menuItem.hasDietaryInfo {
                            Text("No specific dietary information")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    Spacer(minLength: 20)

                    Button {
                        // Add to cart action
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add to Order")
                                .font(LittleLemonTheme.headingFont(18))
                            Spacer()
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(menuItem.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var categoryColor: Color {
        switch menuItem.category {
        case .appetizers:
            return LittleLemonTheme.primaryGreen
        case .mains:
            return LittleLemonTheme.charcoal
        case .drinks:
            return LittleLemonTheme.primaryYellow
        case .desserts:
            return LittleLemonTheme.highlightOrange
        }
    }

    private var categoryIcon: String {
        menuItem.category.icon
    }
}

struct DietaryBadge: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color.opacity(0.2))
        .foregroundColor(color)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        MenuItemDetailsView(menuItem: MenuItem.sample)
    }
}
