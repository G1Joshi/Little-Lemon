//
//  WelcomeView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/11/25.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool
    @State private var currentPage = 0
    @State private var isAnimating = false

    let features = [
        OnboardingFeature(
            icon: "map.fill",
            title: "Discover Locations",
            description: "Find Little Lemon restaurants across multiple cities",
            color: LittleLemonTheme.primaryGreen
        ),
        OnboardingFeature(
            icon: "fork.knife",
            title: "Explore Menu",
            description: "Browse our delicious Mediterranean cuisine with dietary filters",
            color: LittleLemonTheme.highlightOrange
        ),
        OnboardingFeature(
            icon: "calendar",
            title: "Easy Reservations",
            description: "Book your table in seconds and manage your visits",
            color: LittleLemonTheme.primaryYellow
        ),
        OnboardingFeature(
            icon: "heart.fill",
            title: "Save Favorites",
            description: "Mark your favorite dishes and locations for quick access",
            color: Color.red
        ),
    ]

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    LittleLemonLogo()
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(.spring(response: 0.8, dampingFraction: 0.6), value: isAnimating)

                    Text("Welcome to Little Lemon")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .offset(y: isAnimating ? 0 : 20)
                        .animation(.easeOut(duration: 0.8).delay(0.3), value: isAnimating)
                }
                .padding(.top, 60)
                .padding(.bottom, 40)

                TabView(selection: $currentPage) {
                    ForEach(0 ..< features.count, id: \.self) { index in
                        FeatureCard(feature: features[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 350)
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.8).delay(0.5), value: isAnimating)

                Spacer()

                Button(action: {
                    withAnimation(.spring()) {
                        showWelcome = false
                        UserDefaults.standard.set(true, forKey: "hasSeenWelcome")
                    }
                }) {
                    HStack {
                        Text("Get Started")
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LittleLemonTheme.primaryGreen)
                    .cornerRadius(15)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.8).delay(0.7), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct OnboardingFeature {
    let icon: String
    let title: String
    let description: String
    let color: Color
}

struct FeatureCard: View {
    let feature: OnboardingFeature

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(feature.color.opacity(0.2))
                    .frame(width: 120, height: 120)

                Image(systemName: feature.icon)
                    .font(.system(size: 50))
                    .foregroundColor(feature.color)
            }

            Text(feature.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(feature.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

#Preview {
    WelcomeView(showWelcome: .constant(true))
}
