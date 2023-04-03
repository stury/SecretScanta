import SwiftUI

let dataKey = "secretSanta"

func jsonData(_ items: [SecretSantaItem]) -> Data? {
    var result : Data? = nil
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        let data = try encoder.encode(items)
        result = data
        if let string = String(data: data, encoding: .utf8) {
            print(string)
            //  let pasteboard = UIPasteboard.general
            // pasteboard.string = string
        }
    }
    catch {
        print (error.localizedDescription)
    }
    return result
}

func qrItems() -> [SecretSantaItem] {
    var result = [SecretSantaItem]()
    
    let userDefaultsHelper = UserDefaultsHelper()
    if let data = userDefaultsHelper.retrieveData(dataKey) {
        // We've got some previously generated content!  use it!
        // Decode the data into QRJsonItems, then convert to the format we need.
        result = SecretSantaItem.decode(data: data)
        if result.count > 0 {
            print("Loaded previously created content")
        }
    }
    
    if result.count == 0 {
        // Generate new data...
     //   result.append(contentsOf: SecretSantaParticipants(participants: QRSecretSanta.adults).shuffledItems)
     //   result.append(contentsOf: SecretSantaParticipants(participants: QRSecretSanta.cousins).shuffledItems)
        
        result.append(contentsOf: SecretSantaParticipants(participants: QRSecretSanta.family).shuffledItems)
        print( "Generating new content.")
        
        print("total items: \(result.count)")
        if let data = jsonData(result) {
            // save the data to User Defaults
            userDefaultsHelper.storeData(data, key: dataKey)
            print("Saving generated content.")
        }
    }
    return result
}
