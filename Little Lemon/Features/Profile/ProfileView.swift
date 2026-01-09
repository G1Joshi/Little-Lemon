//
//  ProfileView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/11/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(Model.self) var model

    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userPhone: String = ""
    @State private var showingClearAlert = false

    var body: some View {
        VStack(spacing: 0) {
            LittleLemonBanner(size: 80)
                .padding(20)

            ScrollView {
                VStack(spacing: LittleLemonTheme.Spacing.large) {
                    VStack(alignment: .leading, spacing: LittleLemonTheme.Spacing.small) {
                        HStack {
                            Image(systemName: "person.text.rectangle.fill")
                                .foregroundColor(LittleLemonTheme.primaryGreen)
                            Text("Personal Information")
                                .font(LittleLemonTheme.headingFont(18))
                        }
                        .padding(.horizontal, LittleLemonTheme.Spacing.medium)

                        VStack(spacing: LittleLemonTheme.Spacing.small) {
                            ProfileField(icon: "person.fill", label: "Name", text: $userName)
                            Divider()
                            ProfileField(icon: "envelope.fill", label: "Email", text: $userEmail)
                            Divider()
                            ProfileField(icon: "phone.fill", label: "Phone", text: $userPhone)
                        }
                        .padding(LittleLemonTheme.Spacing.medium)
                        .cardStyle()
                        .padding(.horizontal, LittleLemonTheme.Spacing.medium)
                    }

                    VStack(alignment: .leading, spacing: LittleLemonTheme.Spacing.small) {
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .foregroundColor(LittleLemonTheme.primaryGreen)
                            Text("Reservation History")
                                .font(LittleLemonTheme.headingFont(18))
                            Spacer()
                            Text("\(model.reservationHistory.count)")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(LittleLemonTheme.primaryGreen.opacity(0.2))
                                .cornerRadius(10)
                                .foregroundColor(LittleLemonTheme.primaryGreen)
                        }
                        .padding(.horizontal, LittleLemonTheme.Spacing.medium)

                        if model.reservationHistory.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "calendar.badge.exclamationmark")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No reservations yet")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(LittleLemonTheme.Spacing.large)
                            .cardStyle(backgroundColor: LittleLemonTheme.cloud.opacity(0.3))
                            .padding(.horizontal, LittleLemonTheme.Spacing.medium)
                        } else {
                            VStack(spacing: LittleLemonTheme.Spacing.small) {
                                ForEach(model.reservationHistory.reversed()) { reservation in
                                    ReservationHistoryRow(reservation: reservation)
                                }
                            }
                            .padding(LittleLemonTheme.Spacing.small)
                            .cardStyle()
                            .padding(.horizontal, LittleLemonTheme.Spacing.medium)
                        }
                    }

                    VStack(alignment: .leading, spacing: LittleLemonTheme.Spacing.small) {
                        HStack {
                            Image(systemName: "heart.circle.fill")
                                .foregroundColor(LittleLemonTheme.primaryGreen)
                            Text("Favorite Items")
                                .font(LittleLemonTheme.headingFont(18))
                            Spacer()
                            Text("\(model.favoriteMenuItems.count)")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(LittleLemonTheme.primaryGreen.opacity(0.2))
                                .cornerRadius(10)
                                .foregroundColor(LittleLemonTheme.primaryGreen)
                        }
                        .padding(.horizontal, LittleLemonTheme.Spacing.medium)

                        if model.favoriteMenuItems.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "heart.slash")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No favorites yet")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(LittleLemonTheme.Spacing.large)
                            .cardStyle(backgroundColor: LittleLemonTheme.cloud.opacity(0.3))
                            .padding(.horizontal, LittleLemonTheme.Spacing.medium)
                        }
                    }

                    Button(action: {
                        #if os(iOS)
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        #endif
                        showingClearAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                            Text("Clear All Data")
                                .font(LittleLemonTheme.headingFont(18))
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle(isDestructive: true))
                    .padding(.horizontal, LittleLemonTheme.Spacing.medium)
                    .padding(.bottom, LittleLemonTheme.Spacing.xLarge)
                }
            }
        }
        .alert("Clear All Data?", isPresented: $showingClearAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                model.clearAllData()
                userName = ""
                userEmail = ""
                userPhone = ""
            }
        } message: {
            Text(
                "This will clear all your reservations and favorites. This action cannot be undone."
            )
        }
        .onAppear {
            loadUserData()
        }
        .onChange(of: userName) { _, _ in saveUserData() }
        .onChange(of: userEmail) { _, _ in saveUserData() }
        .onChange(of: userPhone) { _, _ in saveUserData() }
    }

    private func loadUserData() {
        userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        userPhone = UserDefaults.standard.string(forKey: "userPhone") ?? ""
    }

    private func saveUserData() {
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPhone, forKey: "userPhone")
    }
}

struct ProfileField: View {
    let icon: String
    let label: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(LittleLemonTheme.primaryGreen)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField(label, text: $text)
                    .textFieldStyle(.plain)
            }
        }
    }
}

struct ReservationHistoryRow: View {
    let reservation: Reservation

    var body: some View {
        VStack(alignment: .leading, spacing: LittleLemonTheme.Spacing.small) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(reservation.restaurant.city)
                        .font(.headline)
                        .foregroundColor(LittleLemonTheme.primaryGreen)
                    Text(reservation.restaurant.neighborhood)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption2)
                        Text(reservation.reservationDate, style: .date)
                            .font(.caption)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                        Text(reservation.reservationDate, style: .time)
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
            }

            Divider()

            HStack {
                Image(systemName: "person.2.fill")
                    .foregroundColor(LittleLemonTheme.primaryGreen)
                    .font(.caption)
                Text("\(reservation.party) guests")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(LittleLemonTheme.Spacing.medium)
        .background(LittleLemonTheme.cloud.opacity(0.3))
        .cornerRadius(LittleLemonTheme.CornerRadius.small)
    }
}

#Preview {
    ProfileView()
        .environment(Model())
}
