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
                    RoundedRectangle(cornerRadius: 16)
                        .fill(categoryColor.opacity(0.2))
                        .frame(height: 200)

                    Image(systemName: categoryIcon)
                        .font(.system(size: 80))
                        .foregroundColor(categoryColor)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Spacer()

                        VStack(spacing: 4) {
                            Text(menuItem.title)
                                .font(.title)
                                .fontWeight(.bold)

                            Image("littleLemonLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .padding(.horizontal, 40)

                            HStack {
                                Image(systemName: categoryIcon)
                                    .foregroundColor(categoryColor)
                                Text(menuItem.menuCategory.rawValue)
                                    .foregroundColor(.secondary)
                            }
                            .font(.subheadline)

                            Text(String(format: "$%.2f", menuItem.price))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(categoryColor)
                        }

                        Spacer()
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)

                        Text(
                            menuItem.description.isEmpty
                                ? "A delicious \(menuItem.menuCategory.rawValue.lowercased()) item from Little Lemon."
                                : menuItem.description
                        )
                        .font(.body)
                        .foregroundColor(.secondary)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.headline)

                        FlowLayout(spacing: 8) {
                            ForEach(menuItem.ingredients, id: \.self) { ingredient in
                                IngredientTag(ingredient: ingredient)
                            }
                        }
                    }

                    Divider()

                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                        Text("Ordered \(menuItem.ordersCount) times")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer(minLength: 20)

                    Button {
                    } label: {
                        Text("Add to Order")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(categoryColor)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(menuItem.title)
        .navigationBarTitleDisplayMode(.inline)
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

struct IngredientTag: View {
    let ingredient: Ingredient

    var body: some View {
        Text(ingredient.rawValue)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
            .cornerRadius(16)
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(
        in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()
    ) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(
                at: CGPoint(
                    x: bounds.minX + result.positions[index].x,
                    y: bounds.minY + result.positions[index].y),
                proposal: ProposedViewSize(result.sizes[index]))
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                sizes.append(size)

                if currentX + size.width > maxWidth, currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                positions.append(CGPoint(x: currentX, y: currentY))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }

            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

#Preview {
    NavigationStack {
        MenuItemDetailsView(menuItem: MockData.foodItems[0])
    }
}
