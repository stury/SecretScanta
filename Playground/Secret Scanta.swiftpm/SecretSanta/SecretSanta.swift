import Foundation


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
            //"You are buying for \(String(cards[next]+1))"))
            result.append(
                SecretSantaItem(name: String(cards[index]+1),
                                message: "https://stury.github.io/SecretScanta/?target=\(cards[next]+1)")
            )
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
