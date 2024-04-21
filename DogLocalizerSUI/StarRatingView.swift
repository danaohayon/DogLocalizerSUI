// StarRatingView.swift

import SwiftUI

struct StarRatingView: View {
    @State private var starCount = 0 // This will keep track of the number of filled stars

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < starCount ? "star.fill" : "star")
                    .font(.caption) // Set the size of the star
                    .onTapGesture {
                        // Update star count based on the star tapped
                        self.starCount = index + 1
                    }
            }
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView()
    }
}
