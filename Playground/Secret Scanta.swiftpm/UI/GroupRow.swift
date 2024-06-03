import SwiftUI

struct GroupRow: View {
    var group: Group
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName:"person.3")
                Text( group.name )
            }
        }   
    }
}

#Preview {
    GroupRow(group:Group(name:"Family", participants: QRSecretSanta.family))
}
