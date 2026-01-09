//
//  ReservationForm.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct ReservationForm: View {
    @Environment(Model.self) var model
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var temporaryReservation = Reservation()
    @State private var showFormInvalidMessage = false
    @State private var errorMessage = ""
    @State private var reservationDate = Date()
    @State private var party: Int = 1
    @State private var specialRequests: String = ""
    @State private var customerName = ""
    @State private var customerPhoneNumber = ""
    @State private var customerEmail = ""
    @State private var mustChangeReservation = false

    private let restaurant: RestaurantLocation

    private let emailRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

    init(_ restaurant: RestaurantLocation) {
        self.restaurant = restaurant
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    EnhancedRestaurantRow(restaurant: restaurant)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section(header: Text("Reservation Details").fontWeight(.semibold)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("PARTY SIZE")
                                .font(.caption)
                                .foregroundColor(.gray)

                            TextField("",
                                      value: $party,
                                      formatter: NumberFormatter())
                            #if os(iOS)
                                .keyboardType(.numberPad)
                            #endif
                                .onChange(of: party) { _, newValue in
                                    party = max(1, min(newValue, 20))
                                }
                        }

                        VStack {
                            DatePicker(selection: $reservationDate, in: Date()...,
                                       displayedComponents: [.date, .hourAndMinute])
                            {}
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section(header: Text("Contact Information").fontWeight(.semibold)) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(LittleLemonTheme.primaryGreen)
                            .frame(width: 30)
                        TextField("Your name...", text: $customerName)
                            .textContentType(.name)
                            .autocapitalization(.words)
                    }

                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(LittleLemonTheme.primaryGreen)
                            .frame(width: 30)
                        TextField("Your phone number...", text: $customerPhoneNumber)
                            .textContentType(.telephoneNumber)
                        #if os(iOS)
                            .keyboardType(.phonePad)
                        #endif
                    }

                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(LittleLemonTheme.primaryGreen)
                            .frame(width: 30)
                        TextField("Your e-mail...", text: $customerEmail)
                        #if os(iOS)
                            .keyboardType(.emailAddress)
                        #endif
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                }

                Section(header: Text("Special Requests (Optional)").fontWeight(.semibold)) {
                    TextEditor(text: $specialRequests)
                        .frame(minHeight: 80)
                        .overlay(
                            Group {
                                if specialRequests.isEmpty {
                                    Text("Add any dietary restrictions or special requests...")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 4)
                                        .padding(.top, 8)
                                        .allowsHitTesting(false)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                }
                            }
                        )
                }

                Section {
                    Button(action: { validateForm() }) {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                            Text("CONFIRM RESERVATION")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    .listRowBackground(LittleLemonTheme.primaryGreen)
                    .foregroundColor(.white)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Make Reservation")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
            .background(LittleLemonTheme.cloud.opacity(0.3))
            .onChange(of: mustChangeReservation) { _, _ in
                model.reservation = temporaryReservation
            }
            .alert(isPresented: $showFormInvalidMessage) {
                .init(title: Text("Validation Error"),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            }
            .onAppear {
                model.displayingReservationForm = true
                loadSavedUserInfo()
            }
            .onDisappear {
                model.displayingReservationForm = false
            }
    }

    private func loadSavedUserInfo() {
        customerName = UserDefaults.standard.string(forKey: "userName") ?? ""
        customerEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        customerPhoneNumber = UserDefaults.standard.string(forKey: "userPhone") ?? ""
    }

    private func validateForm() {
        let trimmedName = customerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = customerEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = customerPhoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)

        var errors: [String] = []

        if !isValid(name: trimmedName) {
            errors.append("• Name must contain only letters and be at least 3 characters long")
        }

        if trimmedPhone.isEmpty {
            errors.append("• Phone number is required")
        }

        if !isValid(email: trimmedEmail) {
            errors.append("• Please enter a valid email address")
        }

        if party < 1 {
            errors.append("• Party size must be at least 1")
        }

        if reservationDate < Date() {
            errors.append("• Reservation date must be in the future")
        }

        guard errors.isEmpty else {
            errorMessage = errors.joined(separator: "\n")
            showFormInvalidMessage = true
            return
        }

        let newReservation = Reservation(
            restaurant: restaurant,
            customerName: trimmedName,
            customerEmail: trimmedEmail,
            customerPhoneNumber: trimmedPhone,
            reservationDate: reservationDate,
            party: party,
            specialRequests: specialRequests.trimmingCharacters(in: .whitespacesAndNewlines)
        )

        temporaryReservation = newReservation
        model.reservation = newReservation
        model.addReservationToHistory(newReservation)

        mustChangeReservation.toggle()
        presentationMode.wrappedValue.dismiss()
    }

    private func isValid(name: String) -> Bool {
        guard !name.isEmpty, name.count >= 3 else { return false }
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        return name.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }

    private func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}

#Preview {
    NavigationView {
        ReservationForm(RestaurantLocation.sample)
            .environment(Model())
    }
}
