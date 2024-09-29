import Vision

@objc(RnQrBarcodeImageScan)
class RnQrBarcodeImageScan: NSObject {
    
  @objc(scanFromPath:withResolver:withRejecter:)
  func scanFromPath(path: String, resolve:@escaping RCTPromiseResolveBlock,reject:@escaping RCTPromiseRejectBlock) -> Void {
    
    guard let url = URL(string: path),
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data) else {
        reject("", "Cannot get image from path: \(path)", nil)
        return
    }
    
    guard let cgImage = image.cgImage else {
      reject("", "Cannot get cgImage from image", nil)
      return
    }
    
    let request = VNDetectBarcodesRequest { request, error in
      guard let results = request.results as? [VNBarcodeObservation], error == nil else {
        reject("", "Cannot get result from VNDetectBarcodesRequest", nil)
        return
      }
      
      let qrCodes = results.compactMap { $0.payloadStringValue }
      resolve(qrCodes)
    }
    
#if targetEnvironment(simulator)
    request.revision = VNDetectBarcodesRequestRevision1
#endif
    
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    do {
        try handler.perform([request])
    } catch {
      reject("", "Error when perform request on VNImageRequestHandler: \(error.localizedDescription)", nil)
    }
  }
    
}
