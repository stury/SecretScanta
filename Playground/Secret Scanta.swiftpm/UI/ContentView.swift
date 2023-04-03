import SwiftUI


struct ContentView: View {
    var items:[SecretSantaItem]
    
    var body: some View {
            List(items, id: \.id) { item in 
                QRItemView(item: item)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(items: QRSecretSanta(participants: QRSecretSanta.adults).shuffledItems)
    }
}
