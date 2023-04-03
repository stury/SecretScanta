import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        let items : [SecretSantaItem] = qrItems()
        
        WindowGroup {
            ContentView(items: items )
        }
    }
}
