//
//  MenuItemsView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

struct MenuItemsView: View {
    @StateObject private var viewModel = MenuViewViewModel()
    @State private var showingOptions = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredMenuItems) { item in
                        NavigationLink(destination: MenuItemDetailsView(menuItem: item)) {
                            MenuItemCard(menuItem: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingOptions = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingOptions) {
                MenuItemsOptionView(viewModel: viewModel)
            }
        }
    }
}

struct MenuItemCard: View {
    let menuItem: MenuItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(categoryColor.opacity(0.2))
                    .frame(height: 120)

                Image(systemName: categoryIcon)
                    .font(.system(size: 40))
                    .foregroundColor(categoryColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(menuItem.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(menuItem.menuCategory.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(String(format: "$%.2f", menuItem.price))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(categoryColor)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }

    private var categoryColor: Color {
        switch menuItem.menuCategory {
        case .food:
            return .orange
        case .drink:
            return .blue
        case .dessert:
            return .pink
        }
    }

    private var categoryIcon: String {
        switch menuItem.menuCategory {
        case .food:
            return "fork.knife"
        case .drink:
            return "cup.and.saucer.fill"
        case .dessert:
            return "birthday.cake.fill"
        }
    }
}

#Preview {
    MenuItemsView()
}
