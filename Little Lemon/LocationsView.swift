//
//  LocationsView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        VStack {
            LittleLemonLogo()
                .padding(.top, 50)

            Text(model.displayingReservationForm ? "Reservation Details" : "Select a location")
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)

            NavigationView {
                List(model.restaurants, id: \.self) { restaurant in
                    NavigationLink {
                        ReservationForm(restaurant)
                    } label: {
                        RestaurantView(restaurant)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        .padding(.top, -10)
    }
}

#Preview {
    LocationsView().environmentObject(Model())
}
