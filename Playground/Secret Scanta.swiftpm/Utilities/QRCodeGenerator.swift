import Foundation
import CoreGraphics
import CoreImage
import UniformTypeIdentifiers
import UIKit

struct QRCodeGenerator {
    enum Correction: String {
        case low = "L"      // 7%
        case medium = "M"   // 15%
        case quartile = "Q" // 25%
        case high = "H"     // 30%
    }
    
    // good tutorial on creating QR Codes:  https://medium.com/@MedvedevTheDev/generating-basic-qr-codes-in-swift-63d7222aa011
    // https://digitalbunker.dev/native-barcode-qr-code-generation-in-swift/
    
    private func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
    func image(message: String, correction: Correction) -> CGImage? {
        let f = CIFilter(name: "CIQRCodeGenerator", parameters: [
            "inputMessage": message.data(using: .isoLatin1)!,
            "inputCorrectionLevel": correction.rawValue])!
        
        let result : CGImage?
        if let outputImage = f.outputImage {
            result =  convertCIImageToCGImage(inputImage: outputImage)
        }
        else {
            result = nil
        }
        return result
    }
}

extension CGImage {
    func scaled(by multiplier: Int) -> CGImage? {
        let w = self.width * multiplier
        let h = self.height * multiplier
        let bpc = self.bitsPerComponent
        let Bpr = self.bytesPerRow * multiplier
        let space = self.colorSpace!
        let info = self.bitmapInfo
        let context = CGContext(data: nil, width: w, height: h,
                                bitsPerComponent: bpc, bytesPerRow: Bpr,
                                space: space, bitmapInfo: info.rawValue)
        context?.interpolationQuality = .none
        context?.draw(self, in: CGRect(x: 0, y: 0, width: w, height: h))
        return context?.makeImage()
    }
    
    //   func export(to url: URL) throws {
    // let ext = url.pathExtension as CFString
    //   let tag = kUTTagClassFilenameExtension
    //    let type = UTTypeCreatePreferredIdentifierForTag(
    //        tag, ext, kUTTypeImage)!.takeUnretainedValue()
    //      let dst = CGImageDestinationCreateWithURL(url as CFURL, type, 1, nil)!
    //     CGImageDestinationAddImage(dst, self, nil)
    //      CGImageDestinationFinalize(dst)
    //  }
}
