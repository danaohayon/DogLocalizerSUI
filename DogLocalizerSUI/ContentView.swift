//
//  ContentView.swift
//  DogLocalizerSUI
//
//  Created by Dana Ohayon on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var imageName:String = "star";
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                Button(action: {
                    favorite()
                }, label: {
                    Image(systemName: imageName)
                })
        }
        .padding()
        
        
    }
    
    func favorite(){
        // if the star is empty, fill when pressed. if full, empty.
        //TODO: have an pbject to favorite and so on
        if (imageName == "star") {
            imageName = "star.fill"
        } else {
            imageName = "star"
        }
    }
    
}

#Preview {
    ContentView()
}
