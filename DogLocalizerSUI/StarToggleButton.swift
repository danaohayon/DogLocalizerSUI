// StarToggleButton.swift

import SwiftUI

struct StarToggleButton: View {
    @State private var isStarFilled = false

    var body: some View {
        Button(action: {
            // Toggle the state when the button is pressed
            self.isStarFilled.toggle()
        }) {
            Image(systemName: isStarFilled ? "star.fill" : "star")
                .font(.caption) // Set the size of the star
        }
    }
}
