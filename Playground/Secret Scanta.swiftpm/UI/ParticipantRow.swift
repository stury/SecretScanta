import SwiftUI

struct ParticipantRow: View {
    var participant: Participant
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName:"person")
                Text( participant.name )
            }
        }   
    }
}

#Preview {
    ParticipantRow(participant:Participant(name: "Joan"))
}
