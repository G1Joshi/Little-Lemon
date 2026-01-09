//
//  MainView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

struct MainView: View {
    @State private var showWelcome = !UserDefaults.standard.bool(forKey: "hasSeenWelcome")

    var body: some View {
        if showWelcome {
            WelcomeView(showWelcome: $showWelcome)
        } else {
            ContentView()
        }
    }
}

#Preview {
    MainView()
        .environment(Model())
}
