import CoreML
import Vision
import UIKit

class ModelManager {
    var model: VNCoreMLModel
    let breedNames: [String] = ["Chihuahua", "Japanese Spaniel", "Maltese Dog", "Pekinese", "Shih", "Blenheim Spaniel", "Papillon", "Toy Terrier", "Rhodesian Ridgeback", "Afghan Hound", "Basset", "Beagle", "Bloodhound", "Bluetick", "Black", "Walker Hound", "English Foxhound", "Redbone", "Borzoi", "Irish Wolfhound", "Italian Greyhound", "Whippet", "Ibizan Hound", "Norwegian Elkhound", "Otterhound", "Saluki", "Scottish Deerhound", "Weimaraner", "Staffordshire Bullterrier", "American Staffordshire Terrier", "Bedlington Terrier", "Border Terrier", "Kerry Blue Terrier", "Irish Terrier", "Norfolk Terrier", "Norwich Terrier", "Yorkshire Terrier", "Wire", "Lakeland Terrier", "Sealyham Terrier", "Airedale", "Cairn", "Australian Terrier", "Dandie Dinmont", "Boston Bull", "Miniature Schnauzer", "Giant Schnauzer", "Standard Schnauzer", "Scotch Terrier", "Tibetan Terrier", "Silky Terrier", "Soft", "West Highland White Terrier", "Lhasa", "Flat", "Curly", "Golden Retriever", "Labrador Retriever", "Chesapeake Bay Retriever", "German Short", "Vizsla", "English Setter", "Irish Setter", "Gordon Setter", "Brittany Spaniel", "Clumber", "English Springer", "Welsh Springer Spaniel", "Cocker Spaniel", "Sussex Spaniel", "Irish Water Spaniel", "Kuvasz", "Schipperke", "Groenendael", "Malinois", "Briard", "Kelpie", "Komondor", "Old English Sheepdog", "Shetland Sheepdog", "Collie", "Border Collie", "Bouvier Des Flandres", "Rottweiler", "German Shepherd", "Doberman", "Miniature Pinscher", "Greater Swiss Mountain Dog", "Bernese Mountain Dog", "Appenzeller", "Entlebucher", "Boxer", "Bull Mastiff", "Tibetan Mastiff", "French Bulldog", "Great Dane", "Saint Bernard", "Eskimo Dog", "Malamute", "Siberian Husky", "Affenpinscher", "Basenji", "Pug", "Leonberg", "Newfoundland", "Great Pyrenees", "Samoyed", "Pomeranian", "Chow", "Keeshond", "Brabancon Griffon", "Pembroke", "Cardigan", "Toy Poodle", "Miniature Poodle", "Standard Poodle", "Mexican Hairless", "Dingo", "Dhole", "African Hunting Dog"]

    init?() {
        do {
            let configuration = MLModelConfiguration()
            let modelContainer = try XceptionModel_3(configuration: configuration)
            self.model = try VNCoreMLModel(for: modelContainer.model)
        } catch {
            print("Failed to load Vision ML model: \(error)")
            return nil
        }
    }

    func preprocessImage(_ image: UIImage) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resizedImage
        }
    
    


    func classifyImage(_ image: UIImage, completion: @escaping (String, CGRect?) -> Void) {
        guard let processedImage = preprocessImage(image),
              let ciImage = CIImage(image: processedImage) else {
            print("Failed to preprocess or convert UIImage to CIImage.")
            return
        }

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
        guard let results = request.results as? [VNCoreMLFeatureValueObservation] else {
            completion("Failed to recognize anything or no results.", nil)
            return
        }

        guard let classPrediction = results.first(where: { $0.featureValue.multiArrayValue?.shape.count == 2 && $0.featureValue.multiArrayValue?.shape[1] == 120 }),
              let bboxPrediction = results.first(where: { $0.featureValue.multiArrayValue?.shape.count == 2 && $0.featureValue.multiArrayValue?.shape[1] == 4 }) else {
            completion("Model output mismatch or not found.", nil)
            return
        }

        let classPredictionArray = classPrediction.featureValue.multiArrayValue!
        var maxConfidence: Float = -1
        var predictedClassIndex: Int = -1

        for i in 0..<120 {
            let confidence = classPredictionArray[i].floatValue
            if confidence > maxConfidence {
                maxConfidence = confidence
                predictedClassIndex = i
            }
        }

        let classLabel = breedNames[predictedClassIndex]

        let bboxPredictionArray = bboxPrediction.featureValue.multiArrayValue!
        let y1 = bboxPredictionArray[0].floatValue
        let x1 = bboxPredictionArray[1].floatValue
        let y2 = bboxPredictionArray[2].floatValue
        let x2 = bboxPredictionArray[3].floatValue

        let boundingBox = CGRect(x: CGFloat(x1),
                                 y: CGFloat(y1),
                                 width: CGFloat(x2 - x1),
                                 height: CGFloat(y2 - y1))

        completion("Class: \(classLabel), Confidence: \(maxConfidence)", boundingBox)
    }

}
