//
//  ContentView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(Model.self) var model

    var body: some View {
        @Bindable var model = model
        TabView(selection: $model.tabViewSelectedIndex) {
            LocationsView()
                .tag(0)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Locations", systemImage: "list.bullet")
                    }
                }

            MapLocationView()
                .tag(1)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Map", systemImage: "map.fill")
                    }
                }

            MenuItemsView()
                .tag(2)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Menu", systemImage: "fork.knife")
                    }
                }

            ReservationView()
                .tag(3)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Reservation", systemImage: "calendar")
                    }
                }

            ProfileView()
                .tag(4)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Profile", systemImage: "person.fill")
                    }
                }
        }
        .accentColor(LittleLemonTheme.primaryGreen)
    }
}

#Preview {
    ContentView()
        .environment(Model())
}
