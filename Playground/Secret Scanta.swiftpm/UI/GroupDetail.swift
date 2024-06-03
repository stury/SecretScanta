import SwiftUI

struct GroupDetail: View {
    //    @State var editMode: EditMode = .inactive //<- Declare the @State var for editMode  
    @State private var path: [SecretSantaParticipants] = []
    @State var group : Group
    
    let buttonSize : CGFloat = 25.0
    
    var body: some View {
        //NavigationView {
        //        NavigationStack(path: $path) {
        
        List {
            Section(header: Text("Participants")) {
                ForEach(group.participants, id: \.self) { participant in
                    NavigationLink(participant.name, value: participant)
                    //                        ParticipantRow( participant: participant)
                }.onDelete { indexSet in
                    group.participants.remove(atOffsets: indexSet)
                }
            }
            Section(header: Text("Operations")) {
                NavigationLink("Randomize", value: group.secretSantaParticipants) 
                //                    NavigationLink("History", value: nil History(group: group))
                
                //                    NavigationLink {
                ////                        let items : [SecretSantaItem] = qrItems(group.participants)
                ////                        ContentView(items: items )
                //                        RandomizedParticipants(group: group)
                //                    } label: {
                //                        Image(systemName: "shuffle")
                //                            .resizable()
                //                            .frame(width: buttonSize, height: buttonSize)
                //                        Text( "Randomize" )
                //                    }
                //                    NavigationLink { 
                //                        // TODO:  Show History of secret santa results!
                //                    } label: { 
                //                        Image(systemName: "fossil.shell")
                //                            .resizable()
                //                            .frame(width: buttonSize, height: buttonSize)
                //                        Text( "History" )
                //                    }
            }
        }
        .listStyle(GroupedListStyle())
        .toolbar {
            Button(action: {
                /// TODO: Add in the ability to add a new person into the group.
            }, label: {
                Image(systemName: "plus")
            })
            //.disabled(editMode != nil).environment(\.editMode, $editMode) //<- And pass the binding explicitly
            EditButton()
        }
        .navigationTitle(group.name)
        
        //            .navigationDestination(for: SecretSantaParticipants.self) { participants in
        //                // let items : [SecretSantaItem] = qrItems(group.participants)
        //                ////                        ContentView(items: items )
        //                RandomizedParticipants(participants: participants)
        //            }
        //            NavigationLink {
        //                let items : [SecretSantaItem] = qrItems(group.participants)
        //                ContentView(items: items )
        //            } label: {
        //                Image(systemName: "plus.circle")
        //                    .resizable()
        //                    .frame(width: buttonSize, height: buttonSize)
        //                Text( "Add" )
        //            }
        //        }
    }
}


#Preview {
    GroupDetail(group: Group(name: "Family", participants: QRSecretSanta.family) )
}
