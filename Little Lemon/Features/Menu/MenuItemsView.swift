//
//  MenuItemsView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

struct MenuItemsView: View {
    @State private var viewModel = MenuViewViewModel()
    @State private var showingOptions = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                LittleLemonBanner(size: 80)
                Spacer()
                Button(action: {
                    showingOptions.toggle()
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(.title)
                        .foregroundColor(LittleLemonTheme.primaryGreen)
                }
            }
            .padding(20)

            ScrollView {
                LazyVGrid(columns: columns, spacing: LittleLemonTheme.Spacing.medium) {
                    ForEach(viewModel.filteredMenuItems) { item in
                        NavigationLink(destination: MenuItemDetailsView(menuItem: item)) {
                            MenuItemCard(menuItem: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingOptions) {
            MenuItemsOptionView(viewModel: viewModel)
        }
    }
}

struct MenuItemCard: View {
    let menuItem: MenuItem

    var body: some View {
        VStack(alignment: .leading, spacing: LittleLemonTheme.Spacing.xSmall) {
            ZStack {
                RoundedRectangle(cornerRadius: LittleLemonTheme.CornerRadius.medium)
                    .fill(categoryColor.opacity(0.2))
                    .frame(height: 120)

                Image(systemName: categoryIcon)
                    .font(.system(size: 40))
                    .foregroundColor(categoryColor)
            }

            VStack(alignment: .leading, spacing: LittleLemonTheme.Spacing.xxSmall) {
                Text(menuItem.name)
                    .font(LittleLemonTheme.bodyFont(16))
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(menuItem.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(menuItem.formattedPrice)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(categoryColor)
            }
            .padding(.horizontal, LittleLemonTheme.Spacing.xSmall)
            .padding(.bottom, LittleLemonTheme.Spacing.xSmall)
        }
        .cardStyle()
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

#Preview {
    MenuItemsView()
}
