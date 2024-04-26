import SwiftUI

struct PhotoViewerView: View {
    @Binding var image: UIImage?
    @State private var isMenuOpen = false
    @State private var isAboutOpen = false
    var chooseNewPhoto: () -> Void

    var body: some View {
        ZStack(alignment: .top){
            Color("panelColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle()
                            if isAboutOpen {isAboutOpen = false}
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                    
                    Spacer()
                    Text("Made by Dana Ohayon")
                        .font(.custom("TrebuchetMS", size: 10))
                        .padding(.vertical, 5)
                        .foregroundColor(Color("AccentColor").opacity(0.7))
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isAboutOpen.toggle()
                            if isMenuOpen {isMenuOpen = false}
                        }
                    }) {
                        Image(systemName: "questionmark.circle")
                    }
                    
                }.padding(.horizontal, 35)
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .padding(.top)
                
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    Text("Classify photo")
                        .font(.title)
                        .padding()
                    Button {
                        chooseNewPhoto()
                    } label: {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.accentColor)
                                .font(.system(size:13))
                                .padding(.bottom, 2)
                            
                            Text("Choose another")
                                .font(.custom("TrebuchetMS", size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                                .padding(.leading, 1)
                            
                        }.padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color("backgroundColor").opacity(0.3))
                            .cornerRadius(20)
                            .padding(.top, 10)
                    }
                }
            }
            .padding()
        }
        if isMenuOpen {
            SideMenu(isMenuOpen: $isMenuOpen)
                .transition(.move(edge: .leading))  // Smooth transition for the menu
        }
        if isAboutOpen {
            About(isAboutOpen: $isAboutOpen)
                .transition(.move(edge: .bottom))  // Smooth transition for the about the project section
        }
    }
}
