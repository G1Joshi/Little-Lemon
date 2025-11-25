//
//  ContentView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = Model()
    @State var tabSelection = 0

    var body: some View {
        TabView(selection: $model.tabViewSelectedIndex) {
            LocationsView()
                .tag(0)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Locations", systemImage: "fork.knife")
                    }
                }

            ReservationView()
                .tag(1)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Reservation", systemImage: "square.and.pencil")
                    }
                }
        }
        .environmentObject(model)
    }
}

#Preview {
    ContentView()
}
