//
//  LittleLemonBanner.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/12/25.
//

import SwiftUI

struct LittleLemonBanner: View {
    var size: CGFloat = 100

    var body: some View {
        Image("littleLemonBanner")
            .resizable()
            .scaledToFit()
            .frame(height: size)
            .accessibilityLabel("Little Lemon Logo")
    }
}

#Preview {
    LittleLemonBanner()
}
