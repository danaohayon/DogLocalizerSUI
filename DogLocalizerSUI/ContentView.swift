//
//  ContentView.swift
//  DogLocalizerSUI
//
//  Created by Dana Ohayon on 01/04/2024.
//

import SwiftUI

struct CustomColors{
    static let bgCol = Color(hex:0xdeccc1)
    static let title = Color(hex:0x705f3a)
}
// Extension to the Color struct to allow initialization using hexadecimal color codes
extension Color {
    // Initializer function that accepts a UInt representing the hexadecimal color code,
        // and an optional alpha value for opacity (default is 1)
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            // Initialize the color using the sRGB color space
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            // Set the opacity to the provided alpha value
            opacity: alpha
        )
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            CustomColors.bgCol
                .edgesIgnoringSafeArea(.all)
            // Content VStack
            VStack {
                // Add Text view with "Hello, world!" text
                Text("Hello, world!")
                    .foregroundColor(CustomColors.title)// Set text color
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 100.0)
                
                // Add Text view with "Dana" text
                Text("Dana")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex:0x3a291b)) // Set text color
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
