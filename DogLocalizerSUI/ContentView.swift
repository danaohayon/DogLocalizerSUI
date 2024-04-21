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
                ZStack{
                    Image(systemName:"dog.fill")
                        .foregroundColor(.white)
                        .padding()
                    Image(systemName:"dog")
                        .foregroundColor(.accentColor)
                        .padding()
                }
                Text("Welcome to my dog localization project!")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("titleColor"))
                    .multilineTextAlignment(.center)
                ZStack{
                    Image(systemName: "camera.fill")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding()
                    
                    Image(systemName: "camera")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .padding()
                }
                HStack {
                    Text("Rating:")
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                    StarRatingView()
                }
                .foregroundColor(.accentColor)
                .padding(10)
                .background(Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(10))
                .font(.caption)
                
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
