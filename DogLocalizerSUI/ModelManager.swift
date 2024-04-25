import SwiftUI
import CoreML
import Vision

class ModelManager: ObservableObject {
    @Published var predictionResult: String?  // Example of a published property

    private var model: VNCoreMLModel?

    init() {
        do {
            let coreMLModel = try finalModel(configuration: MLModelConfiguration())
            model = try VNCoreMLModel(for: coreMLModel.model)
        } catch {
            print("Error initializing the model: \(error)")
        }
    }

    func performPrediction(inputImage: CGImage) {
        guard let model = model else { return }

        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNRecognizedObjectObservation],
                  let topResult = results.first else {
                self?.predictionResult = "Failed to perform classification and detection."
                return
            }
            DispatchQueue.main.async {
                // Update the UI on the main thread
                self?.predictionResult = "Most likely class: \(topResult.labels.first?.identifier ?? "Unknown"), confidence: \(topResult.labels.first?.confidence ?? 0)"
            }
        }

        request.imageCropAndScaleOption = .scaleFill

        let handler = VNImageRequestHandler(cgImage: inputImage)
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform image classification and detection: \(error)")
            DispatchQueue.main.async {
                self.predictionResult = "Error: \(error.localizedDescription)"
            }
        }
    }
}
