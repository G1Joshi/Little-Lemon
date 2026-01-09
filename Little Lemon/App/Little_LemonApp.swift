//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    @State private var model = Model()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(model)
        }
    }
}
