import SwiftUI

struct GroupList: View {
    @State var groups : [Group]
    @State var editMode = false
    
    var body: some View {
        List {
            ForEach(groups, id: \.self) { group in
                NavigationLink(group.name, value: group)
                //                    NavigationLink {
                //                        GroupDetail(group: group)
                //                    } label: {
                //                        GroupRow(group: group)
                //                    }
            }.onDelete { indexSet in
                groups.remove(atOffsets: indexSet)
            }
        }
        .toolbar {
            Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            })
            EditButton()
        }
        .navigationTitle("Groups")
    }
}

#Preview {
    GroupList(groups: [
        Group(name: "Adults", participants: QRSecretSanta.adults),
        Group(name: "Cousins", participants: QRSecretSanta.cousins),
        Group(name: "Family", participants: QRSecretSanta.family)
    ])
}
