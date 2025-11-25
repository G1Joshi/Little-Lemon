//
//  ReservationForm.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct ReservationForm: View {
    @EnvironmentObject var model: Model
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

    private var restaurant: RestaurantLocation

    init(_ restaurant: RestaurantLocation) {
        self.restaurant = restaurant
    }

    var body: some View {
        VStack {
            Form {
                RestaurantView(restaurant)

                HStack {
                    VStack(alignment: .leading) {
                        Text("PARTY")
                            .font(.subheadline)

                        TextField("",
                                  value: $party,
                                  formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .onChange(of: party) {
                                if party < 1 { party = 1 }
                            }
                    }

                    VStack {
                        DatePicker(selection: $reservationDate, in: Date()...,
                                   displayedComponents: [.date, .hourAndMinute])
                        {}
                    }
                }
                .padding([.top, .bottom], 20)

                Group {
                    Group {
                        HStack {
                            Text("NAME: ")
                                .font(.subheadline)
                            TextField("Your name...",
                                      text: $customerName)
                        }

                        HStack {
                            Text("PHONE: ")
                                .font(.subheadline)

                            TextField("Your phone number...",
                                      text: $customerPhoneNumber)
                                .textContentType(.telephoneNumber)
                                .keyboardType(.phonePad)
                        }

                        HStack {
                            Text("E-MAIL: ")
                                .font(.subheadline)
                            TextField("Your e-mail...",
                                      text: $customerEmail)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }

                        TextField("add any special request (optional)",
                                  text: $specialRequests,
                                  axis: .vertical)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)))
                            .lineLimit(6)
                            .padding([.top, .bottom], 20)
                    }

                    Button(action: { validateForm() }, label: {
                        Text("CONFIRM RESERVATION")
                    })
                    .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 10)
                }
            }

            .padding(.top, -40)
            .scrollContentBackground(.hidden)
            .onChange(of: mustChangeReservation) {
                model.reservation = temporaryReservation
            }
            .alert(isPresented: $showFormInvalidMessage) {
                .init(title: Text("Error"), message: Text(errorMessage))
            }
        }
        .onAppear {
            model.displayingReservationForm = true
        }
        .onDisappear {
            model.displayingReservationForm = false
        }
    }

    private func validateForm() {
        let nameIsValid = isValid(name: customerName)
        let emailIsValid = isValid(email: customerEmail)

        guard nameIsValid, emailIsValid
        else {
            var invalidNameMessage = ""
            if customerName.isEmpty || !isValid(name: customerName) {
                invalidNameMessage = "Names can only contain letters and must have at least 3 characters\n\n"
            }

            var invalidPhoneMessage = ""
            if customerEmail.isEmpty {
                invalidPhoneMessage = "The phone number cannot be blank.\n\n"
            }

            var invalidEmailMessage = ""
            if !customerEmail.isEmpty || !isValid(email: customerEmail) {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }

            errorMessage = "Found these errors in the form:\n\n \(invalidNameMessage)\(invalidPhoneMessage)\(invalidEmailMessage)"

            showFormInvalidMessage.toggle()
            return
        }

        let temporaryReservation = Reservation(
            restaurant: restaurant,
            customerName: customerName,
            customerEmail: customerEmail,
            customerPhoneNumber: customerPhoneNumber,
            reservationDate: reservationDate,
            party: party,
            specialRequests: specialRequests
        )

        self.temporaryReservation = temporaryReservation

        mustChangeReservation.toggle()

        presentationMode.wrappedValue.dismiss()
    }

    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 2
        else { return false }
        for chr in name {
            if !(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") {
                return false
            }
        }
        return true
    }

    func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

#Preview {
    let sampleRestaurant = RestaurantLocation(city: "Las Vegas", neighborhood: "Downtown", phoneNumber: "(702) 555-9898")
    ReservationForm(sampleRestaurant).environmentObject(Model())
}
