import UIKit

/// Perhaps we should change this to be a struct that doesn't store an image, 
/// and instead, only stores the message.  The qrCode can be an extension,
/// which then mens it'll be a simple object which can be converted into a JSON 
/// object easily.
public struct SecretSantaItem : Hashable, Identifiable, Codable, Comparable { 
    static let qrGenerator = QRCodeGenerator()
    
    public let id : Int
    let name : String
    let message : String
    
    /// image is a computed property.  This way we can make this object be codable,
    /// and we don't have to worry about dealing with the actual image. Encoding 
    /// image is a bit cumbersome, and we can always regenerate the image again from the text.
    var image : UIImage? {
        get {
            var result: UIImage? = nil
            if let image = SecretSantaItem.qrGenerator.image(message: message, correction: .quartile) {
                if let scaledImage = image.scaled(by: 8) {
                    result = UIImage(cgImage: scaledImage)
                }
            }
            return result
        }
    }
    
    init(name: String, message: String) {
        self.id = UUID().hashValue
        self.name = name
        self.message = message
    }
    
    static func decode(data: Data) -> [SecretSantaItem] {
        var result = [SecretSantaItem]()
        let decoder = JSONDecoder()
        do {
            result = try decoder.decode([SecretSantaItem].self, from: data)
        }
        catch {
            print( error.localizedDescription )
        }
        return result
    }
    
    /// Comparable protocol support
    
    public static func < (lhs: SecretSantaItem, rhs: SecretSantaItem) -> Bool {
        return lhs.name < rhs.name
    }
    
    public static func == (lhs: SecretSantaItem, rhs: SecretSantaItem) -> Bool {
        return lhs.name == rhs.name
    }
}

