import SwiftUI

struct PhotoViewerView: View {
    @Binding var image: UIImage?
    var chooseNewPhoto: () -> Void
    @State private var classificationLabel: String = ""
    @State private var boundingBox: CGRect?
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var processedImage: UIImage?


    var body: some View {
        ZStack(alignment: .top){
            Color("panelColor")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            navigationManager.isSideMenuOpen = true
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
                            navigationManager.currentPage = "about"
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
                        .padding(.vertical)
                        .overlay(RectangleOverlay(boundingBox: boundingBox))
                }
                if let image = processedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
               
                    Button {
                        if let image = self.image {
                            let manager = ModelManager()
                            if let processed = manager?.preprocessImage(image) {
                                self.processedImage = processed // Now you can visually inspect the processed image
                                manager?.classifyImage(processed) { label, box in
                                    self.classificationLabel = label
                                    self.boundingBox = box
                                }
                            }
                        }
                    } label: {
                        HStack{
                            Text("Classify Image")
                                .font(.custom("TrebuchetMS", size: 26))
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                                .padding(.leading, 1)
                            
                        }.padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color("backgroundColor").opacity(0.3))
                            .cornerRadius(20)
                            .padding(.top, 10)
                    }
                    
                    Text(classificationLabel)
                    
                    Button {
                        chooseNewPhoto()
                    } label: {
                        HStack{
                            Image(systemName: "arrow.counterclockwise")
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
    }


struct RectangleOverlay: View {
    var boundingBox: CGRect?

    var body: some View {
        GeometryReader { geometry in
            if let boundingBox = boundingBox {
                Rectangle()
                    .path(in: CGRect(
                        x: boundingBox.origin.x * geometry.size.width,
                        y: boundingBox.origin.y * geometry.size.height,
                        width: boundingBox.size.width * geometry.size.width,
                        height: boundingBox.size.height * geometry.size.height))
                    .stroke(Color.red, lineWidth: 3)
            }
        }
    }
}

