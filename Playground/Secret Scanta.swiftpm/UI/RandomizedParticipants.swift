import SwiftUI

struct RandomizedParticipants: View {
    
    //    let group : Group
    let secretSantaParticipants : SecretSantaParticipants
    var items:[SecretSantaItem]
    
    init( participants: SecretSantaParticipants ) {
        self.secretSantaParticipants = participants
        
        // Now use the SecretSantaParticipants class to shuffle the array and generate a randomized list.
        self.items = secretSantaParticipants.shuffledItems
    }
    
    var body: some View {
        List(items, id: \.id) { item in
            NavigationLink(item.name, value: item)
            //                NavigationLink {
            //                    QRItemView(item: item)
            //                } label: {
            //                    ParticipantRow(participant: Participant(name: item.name))
            //                }
        }
        .navigationTitle("Randomized List")
    }
}

#Preview {
    RandomizedParticipants(participants:Group(name:"Family", participants: QRSecretSanta.family).secretSantaParticipants)
}
