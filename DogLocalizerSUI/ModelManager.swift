import CoreML
import Vision
import UIKit

class ModelManager {
    var model: VNCoreMLModel

    init?() {
        do {
            let configuration = MLModelConfiguration()
            let modelContainer = try finalModel(configuration: configuration)
            self.model = try VNCoreMLModel(for: modelContainer.model)
        } catch {
            print("Failed to load Vision ML model: \(error)")
            return nil
        }
    }
    
    func preprocessImage(_ image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()

        guard let cgImage = resizedImage.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        let context = CIContext()
        guard let filter = CIFilter(name: "CIColorControls") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
//        filter.setValue(0.5, forKey: "inputBrightness") // Adjusts brightness to center around zero
//        filter.setValue(2.0, forKey: "inputContrast")   // Scales values to range -1 to 1

        guard let outputImage = filter.outputImage,
              let outputCGImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: outputCGImage)
    }



    func classifyImage(_ image: UIImage, completion: @escaping (String, CGRect?) -> Void) {
        guard let processedImage = preprocessImage(image),
              let ciImage = CIImage(image: processedImage) else {
            print("Failed to preprocess or convert UIImage to CIImage.")
            return
        }
        print("Image preprocessed for classification.")

        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Error during model execution: \(error.localizedDescription)")
                return
            }
            self.processObservations(request, completion: completion)
        }
        request.imageCropAndScaleOption = .scaleFill
        print("Model request configured and ready to execute.")

        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up, options: [:])
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
                print("Classification performed successfully.")
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }



    private func processObservations(_ request: VNRequest, completion: (String, CGRect?) -> Void) {
        guard let results = request.results as? [VNRecognizedObjectObservation], !results.isEmpty else {
            completion("Failed to recognize anything or no results.", nil)
            return
        }
        // Log details about the observations to understand what's being detected
        for result in results {
            print("Detected object with confidence \(result.confidence) and labels \(result.labels.map { "\($0.identifier): \($0.confidence)" })")
        }
        // Assuming you are interested in the highest confidence result
        if let firstResult = results.max(by: { $0.confidence < $1.confidence }) {
            let confidence = firstResult.confidence
            let classLabel = firstResult.labels.first?.identifier ?? "Unknown"
            let boundingBox = firstResult.boundingBox
            completion("Class: \(classLabel), Confidence: \(confidence)", boundingBox)
        } else {
            completion("No valid results", nil)
        }
    }

}
