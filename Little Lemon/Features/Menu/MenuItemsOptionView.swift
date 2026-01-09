//
//  MenuItemsOptionView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

struct MenuItemsOptionView: View {
    var viewModel: MenuViewViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            Form {
                Section {
                    ForEach(MenuCategory.allCases, id: \.self) { category in
                        CategoryToggleRow(
                            category: category,
                            isSelected: viewModel.isCategorySelected(category)
                        ) {
                            viewModel.toggleCategory(category)
                        }
                    }
                } header: {
                    Text("SELECTED CATEGORIES")
                }

                Section {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        SortOptionRow(
                            option: option,
                            isSelected: viewModel.selectedSortOption == option
                        ) {
                            viewModel.selectedSortOption = option
                        }
                    }
                } header: {
                    Text("SORT BY")
                }
            }
            .navigationTitle("Menu Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CategoryToggleRow: View {
    let category: MenuCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: categoryIcon)
                    .foregroundColor(categoryColor)
                    .frame(width: 30)

                Text(category.rawValue)
                    .foregroundColor(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var categoryIcon: String {
        category.icon
    }

    private var categoryColor: Color {
        switch category {
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
}

struct SortOptionRow: View {
    let option: SortOption
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: optionIcon)
                    .foregroundColor(.secondary)
                    .frame(width: 30)

                Text(option.rawValue)
                    .foregroundColor(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var optionIcon: String {
        switch option {
        case .price:
            return "dollarsign.circle"
        case .alphabetical:
            return "textformat.abc"
        }
    }
}

#Preview {
    MenuItemsOptionView(viewModel: MenuViewViewModel())
}
