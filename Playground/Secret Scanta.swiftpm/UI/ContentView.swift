import SwiftUI

struct ContentView: View {
    var items:[SecretSantaItem]
    
    var body: some View {
        List(items, id: \.id) { item in 
            QRItemView(item: item)
        }
    }
}

#Preview {
    ContentView(items: QRSecretSanta(participants: QRSecretSanta.adults).shuffledItems)
}
