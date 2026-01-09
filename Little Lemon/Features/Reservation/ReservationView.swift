//
//  ReservationView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct ReservationView: View {
    @Environment(Model.self) var model
    @State private var showCancelAlert = false

    var body: some View {
        let restaurant = model.reservation.restaurant

        ScrollView {
            VStack(spacing: 0) {
                LittleLemonBanner(size: 80)
                    .padding(20)

                if restaurant.city.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                            .padding(.top, 60)

                        Text("No Active Reservation")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)

                        Text("Visit Locations to make a reservation")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)

                        Button(action: { model.tabViewSelectedIndex = 0 }) {
                            HStack {
                                Image(systemName: "map.fill")
                                Text("Browse Locations")
                            }
                            .fontWeight(.semibold)
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .padding(.top, 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()

                } else {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Image(systemName: "building.2.fill")
                                    .foregroundColor(LittleLemonTheme.primaryGreen)
                                    .font(.title2)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("RESTAURANT")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(restaurant.city)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text(restaurant.neighborhood)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }

                            HStack(spacing: 4) {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(LittleLemonTheme.primaryGreen)
                                    .font(.caption)
                                Text(restaurant.phoneNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            HStack(spacing: 3) {
                                ForEach(0 ..< 5) { index in
                                    Image(
                                        systemName: index < Int(restaurant.rating)
                                            ? "star.fill" : "star"
                                    )
                                    .font(.caption)
                                    .foregroundColor(LittleLemonTheme.primaryYellow)
                                }
                                Text(String(format: "%.1f", restaurant.rating))
                                    .font(LittleLemonTheme.bodyFont(12))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .cardStyle()
                        .padding(.horizontal)
                        .padding(.top, -40)

                        Divider()
                            .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 15) {
                            Text("GUEST DETAILS")
                                .font(.caption)
                                .foregroundColor(.gray)

                            InfoRow(
                                icon: "person.fill", label: "Name",
                                value: model.reservation.customerName
                            )
                            InfoRow(
                                icon: "envelope.fill", label: "Email",
                                value: model.reservation.customerEmail
                            )
                            InfoRow(
                                icon: "phone.fill", label: "Phone",
                                value: model.reservation.customerPhoneNumber
                            )
                        }
                        .padding()
                        .cardStyle()
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 15) {
                            Text("RESERVATION DETAILS")
                                .font(.caption)
                                .foregroundColor(.gray)

                            HStack {
                                Image(systemName: "person.2.fill")
                                    .foregroundColor(LittleLemonTheme.primaryGreen)
                                    .frame(width: 30)

                                VStack(alignment: .leading) {
                                    Text("Party Size")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(model.reservation.party) guests")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                Spacer()
                            }

                            HStack {
                                Image(systemName: "calendar.circle.fill")
                                    .foregroundColor(LittleLemonTheme.primaryGreen)
                                    .frame(width: 30)

                                VStack(alignment: .leading) {
                                    Text("Date")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(model.reservation.reservationDate, style: .date)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                Spacer()
                            }

                            HStack {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(LittleLemonTheme.primaryGreen)
                                    .frame(width: 30)

                                VStack(alignment: .leading) {
                                    Text("Time")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(model.reservation.reservationDate, style: .time)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .cardStyle()
                        .padding(.horizontal)

                        if !model.reservation.specialRequests.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("SPECIAL REQUESTS")
                                    .font(.caption)
                                    .foregroundColor(.gray)

                                Text(model.reservation.specialRequests)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .cardStyle()
                            .padding(.horizontal)
                        }

                        Button(action: { showCancelAlert = true }) {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                Text("Cancel Reservation")
                            }
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                    .padding(.top, 10)
                }
            }
        }
        .background(LittleLemonTheme.cloud.opacity(0.3))
        .alert("Cancel Reservation?", isPresented: $showCancelAlert) {
            Button("Keep", role: .cancel) {}
            Button("Cancel", role: .destructive) {
                model.reservation = Reservation()
            }
        } message: {
            Text("Are you sure you want to cancel this reservation?")
        }
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(LittleLemonTheme.primaryGreen)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            Spacer()
        }
    }
}

#Preview {
    ReservationView()
        .environment(Model())
}
