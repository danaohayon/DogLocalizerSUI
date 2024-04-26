import SwiftUI

struct Photo: Identifiable {
    var id = UUID()
    var imageName: String
    var description: String
}

struct CustomPageIndicatorView: View {
    var currentIndex: Int
    var pageCount: Int
    
    var body: some View {
        HStack {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color("AccentColor") : Color("AccentColor").opacity(0.5))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.bottom, 5)
    }
}


struct PhotoSwipeView: View {
    let photos: [Photo] = [
        Photo(imageName: "photo1", description: "A photo of a dog from the Stanford Dogs dataset"),
        Photo(imageName: "photo2", description: "The original photo with the REAL bounding box"),
        Photo(imageName: "photo3", description: "That same photo, resized to fit the model requirements"),
        Photo(imageName: "photo4", description: "The photo with the REAL and PREDICTED \nbounding box and classification")
    ]
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex) {
                ForEach(photos.indices, id: \.self) { index in
                    VStack {
                        Image(photos[index].imageName)
                            .resizable()
                            .scaledToFit()
                        Text(photos[index].description)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color("AccentColor"))
                            .font(.custom("TrebuchetMS", size: 11))
                            .fontWeight(.bold)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 350) // Adjust as needed
            
            CustomPageIndicatorView(currentIndex: selectedIndex, pageCount: photos.count)

        }
    }
    
    struct PhotoSwipeView_Previews: PreviewProvider {
        static var previews: some View {
            PhotoSwipeView()
        }
    }
}
