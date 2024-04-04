//
//  ContentView.swift
//  DogLocalizerSUI
//
//  Created by Dana Ohayon on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
                Color("backgroundColor")
                    .edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "camera")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding()
                
                HStack {
                    Text("Hello, world!")
                        .fontWeight(.black)
                        .foregroundColor(Color("titleColor"))
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("Dana")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("headingColor")) // Set text color
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
