import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @ObservedObject var modelManager = ModelManager()
    @State private var predictionResult: String?
    
    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            }
//            Button("Upload Photo") {
//                isPickerShowing = true
//            }
//            .sheet(isPresented: $isPickerShowing) {
//                PhotoPicker(selectedImage: $image)
//            }
//        }
//        
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                
                if let result = predictionResult {
                    Text(result)
                        .padding()
                }

                Button("Select Image") {
                    showingImagePicker = true
                }

                Button("Classify Image") {
                    classifyImage()
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                PhotoPicker(selectedImage: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    func classifyImage() {
        guard let inputCGImage = inputImage?.cgImage else { return }
        // This method now simply triggers the prediction.
        modelManager.performPrediction(inputImage: inputCGImage)
        // There's no need to assign a result here since `performPrediction` will update `predictionResult`.
    }
}

#Preview{
    ContentView()
}

        
