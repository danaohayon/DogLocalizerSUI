import SwiftUI



struct ContentView: View {
    @State private var image: UIImage?
    @State private var isPickerShowing = false
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            Button("Upload Photo") {
                isPickerShowing = true
            }
            .sheet(isPresented: $isPickerShowing) {
                PhotoPicker(selectedImage: $image)
            }
        }
    }
        
}

#Preview{
    ContentView()
}
