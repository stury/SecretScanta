//
//  ContentView.swift
//  SecretScanta
//
//  Created by J. Scott Tury on 11/30/23.
//

import SwiftUI

struct MainContentView: View {
    @State private var path: NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            GroupList(groups: loadGroups())
            .navigationTitle("Groups")
            .navigationDestination(for: Group.self) { group in
                GroupDetail(group: group)
            }
            .navigationDestination(for: SecretSantaParticipants.self) {
                participants in
                // let items : [SecretSantaItem] = qrItems(group.participants)
                ////                        ContentView(items: items )
                RandomizedParticipants(participants: participants)
            }
            .navigationDestination(for: Participant.self) {
                participant in
                ParticipantRow( participant: participant)
            }
            .navigationDestination(for: SecretSantaItem.self) {
                secretSantaItem in
                QRItemView(item: secretSantaItem)
            }
        }
    }
    
    func loadGroups() -> [Group] {
        return [
            Group(name: "Adults", participants: QRSecretSanta.adults),
            Group(name: "Cousins", participants: QRSecretSanta.cousins),
            Group(name: "Family", participants: QRSecretSanta.family)
        ]
    }
}

#Preview {
    MainContentView()
}
