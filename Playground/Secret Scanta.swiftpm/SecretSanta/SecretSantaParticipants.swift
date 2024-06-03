import Foundation

/// Extending Secret Santa to add in the ability to specify an array of 
/// participants.  I've also added a mode where you can pass in an array of names,
/// the same algorithm happens, but the output is who buys a gift for whom.
/// unfortunately this makes it so everyone can see the combinations.  maybe there's
/// another thing I can do to obfuscate the gifted.  QR Code, perhaps?
public class SecretSantaParticipants:SecretSanta, Equatable, Hashable {
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
    
    // MARK: Equatable
    static public func == (lhs: SecretSantaParticipants, rhs: SecretSantaParticipants) -> Bool {
        return 
        lhs.numParticipants == rhs.numParticipants &&
        lhs.participants == rhs.participants 
    }
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(numParticipants)
        for participant in participants {
            hasher.combine(participant)            
        }
    }
}
