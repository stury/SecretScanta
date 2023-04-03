import UIKit


extension Array {
    /// shift a given index 1 from where we are.  
    /// if we get an index out of range, return 0 
    func shift(_ index:Int) -> Int {
        var result = index + 1
        if index >= self.count-1 {
            result = 0
        }
        return result
    }
}

/// Secret Santa algorithm as described by Numberphile on YouTube
/// https://youtu.be/GhnCj7Fvqt0
///
/// Just initialize the SecretSanta struct with how many participants you have,
/// then call the markdown() function to get the report.
/// Put that into a Markdown renderer, like iA Writer, and print out the 
/// combinations.  Cut them at the dividers, and fold those up into a hat.
/// let everyone pull a piece of paper from the hat.  Put a sheet out,
/// for people to identify their number.  When everyone has signed, 
/// everyone can figure out who they need to buy a gift for.
///
public class SecretSanta {
    /// The number of participants in the secret santa exchange.
    let numParticipants:Int
    /// Computed property to automatically shuffle the items, and give you an array back of SecretSantaItems.
    var shuffledItems : [SecretSantaItem] {
        get {
            return secretSantaItems(shuffle())
        }
    }
    
    public init(_ numParticipants:Int) {
        self.numParticipants = numParticipants
    }
    
    private func createArray() -> [Int] {
        var result = [Int]()
        if numParticipants > 0 {
            for num in 0..<numParticipants {
                result.append(num)
            }
        }
        if numParticipants != result.count {
            print("array does not contain \(numParticipants) items!")
        }
        return result
    }
    
    /// Method for shuffling the participants. 
    func shuffle(_ maxShuffles:Int = 1) -> [Int] {
        var result = createArray()
        for _ in 1...maxShuffles {
            result.shuffle()
        }
        return result
    }
    
    /// This method generates an array of SecretSantaItems.
    func secretSantaItems(_ cards:[Int]) -> [SecretSantaItem] {
        var result = [SecretSantaItem]()
        for index in 0..<cards.count {
            let next = cards.shift(index)
            result.append(SecretSantaItem(name: String(cards[index]+1), message: "https://stury.github.io/SecretScanta/?target=\(cards[next]+1)")) //"You are buying for \(String(cards[next]+1))"))
        }
        
        return result.sorted()
    }
    
    /// This method generates Markdown text for the shuffled items.
    func markdown(_ cards:[Int]) -> String {
        var result = ""
        let items = secretSantaItems( cards )
        for item in items {
            result += "\nYou are number \(item.name)\n"
            result += "\n\(item.message)\n"
            result += "\n-----\n"
        }
        
        return result
    }
    
    /// This method shuffles the participants, then generates markdown text for the results.
    public func markdown() -> String {
        return markdown(shuffle())
    }
}

/// Extending Secret Santa to add in the ability to specify an array of 
/// participants.  I've also added a mode where you can pass in an array of names,
/// the same algorithm happens, but the output is who buys a gift for whom.
/// unfortunately this makes it so everyone can see the combinations.  maybe there's
/// another thing I can do to obfuscate the gifted.  QR Code, perhaps?
public class SecretSantaParticipants:SecretSanta {
    /// The list of participants in the gift exchange.
    let participants:[String]
    
    public init(participants:[String]) {
        self.participants = participants
        super.init(self.participants.count)
    }
    
    /// This method generates an array of QRSecretSantaItems.
    override func secretSantaItems(_ cards:[Int]) -> [SecretSantaItem] {
        var result = [SecretSantaItem]()
        for index in 0..<cards.count {
            let next = cards.shift(index)
            result.append(SecretSantaItem(name: participants[cards[index]], message:"https://stury.github.io/SecretScanta/?target=\(participants[cards[next]])")) //"You are buying for \(participants[cards[next]])"))
        }
        
        return result.sorted()
    }
    
    override func markdown(_ cards:[Int]) -> String {
        var result = ""
        
        if participants.count > 0 {
            let items = secretSantaItems(cards)
            for item in items {
                result += "\n\(item.name): \(item.message)\n"
                result += "\n-----\n"
            }
        }
        else {
            result = super.markdown(cards)
        }
        
        return result
    }
}

/// Perhaps we should change this to be a struct that doesn't store an image, 
/// and in stead, only stores the message.  The qrCode can be an extension,
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

/// Currently this class is only a hold over for the hard coded 
/// groups of people that we have identified as belonging to a group. 
class QRSecretSanta : SecretSantaParticipants {
    static let adults  = ["Ray","Ann","Susan","Paul","Jackie","Scott","Joan"]
    static let cousins = ["Lee","Charlotte","James","Holly","Joseph","Hunter","Autumn","Zoe"]
    static let family  = ["Scott", "Joan", "Lee", "Charlotte", "James", "Holly", "Joseph"]
}
