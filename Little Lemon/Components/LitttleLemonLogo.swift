//
//  LitttleLemonLogo.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 24/11/25.
//

import SwiftUI

struct LittleLemonLogo: View {
    var size: CGFloat = 100

    var body: some View {
        Image("littleLemonLogo")
            .resizable()
            .scaledToFit()
            .frame(width: size)
            .accessibilityLabel("Little Lemon Logo")
    }
}

#Preview {
    LittleLemonLogo()
}
