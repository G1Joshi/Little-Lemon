//
//  Theme.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/11/25.
//

import SwiftUI

enum LittleLemonTheme {
    static let primaryGreen = Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
    static let primaryYellow = Color(red: 244 / 255, green: 206 / 255, blue: 20 / 255)

    static let highlightOrange = Color(red: 238 / 255, green: 153 / 255, blue: 114 / 255)
    static let highlightPeach = Color(red: 251 / 255, green: 218 / 255, blue: 187 / 255)

    static let cloud = Color(red: 237 / 255, green: 239 / 255, blue: 238 / 255)
    static let charcoal = Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255)

    static let primaryGradient = LinearGradient(
        colors: [primaryGreen, primaryGreen.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accentGradient = LinearGradient(
        colors: [highlightOrange, highlightPeach],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let cardGradient = LinearGradient(
        colors: [Color.white, cloud.opacity(0.5)],
        startPoint: .top,
        endPoint: .bottom
    )

    static func headingFont(_ size: CGFloat = 24) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }

    static func bodyFont(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }

    enum Spacing {
        static let xxSmall: CGFloat = 4
        static let xSmall: CGFloat = 8
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xLarge: CGFloat = 32
        static let xxLarge: CGFloat = 48
    }

    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xLarge: CGFloat = 20
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var isDestructive: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isDestructive ? Color.red : LittleLemonTheme.primaryGreen)
            .foregroundColor(.white)
            .cornerRadius(LittleLemonTheme.CornerRadius.medium)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.clear)
            .foregroundColor(LittleLemonTheme.primaryGreen)
            .overlay(
                RoundedRectangle(cornerRadius: LittleLemonTheme.CornerRadius.medium)
                    .stroke(LittleLemonTheme.primaryGreen, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct CardModifier: ViewModifier {
    var backgroundColor: Color = .white

    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(LittleLemonTheme.CornerRadius.large)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct FloatingActionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(LittleLemonTheme.primaryGreen)
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0),
                        Color.white.opacity(0.3),
                        Color.white.opacity(0),
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(30))
                .offset(x: phase)
            )
            .clipped()
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 400
                }
            }
    }
}

extension View {
    func cardStyle(backgroundColor: Color = .white) -> some View {
        modifier(CardModifier(backgroundColor: backgroundColor))
    }

    func floatingAction() -> some View {
        modifier(FloatingActionModifier())
    }

    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }

    func themeCornerRadius(_ radius: CGFloat = LittleLemonTheme.CornerRadius.medium) -> some View {
        cornerRadius(radius)
    }
}

struct AnimatedGradientBackground: View {
    @State private var animateGradient = false

    var body: some View {
        LinearGradient(
            colors: [
                LittleLemonTheme.primaryGreen.opacity(0.3),
                LittleLemonTheme.highlightOrange.opacity(0.2),
                LittleLemonTheme.primaryYellow.opacity(0.2),
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}
