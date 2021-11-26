//
//  Styles.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 26/11/2021.
//

import Foundation
import SwiftUI
struct AnimatedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.gray)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
