import Foundation

/// Group struct to keep track of the name of hte group, and who the participants are.
struct Group : Hashable, Codable, Identifiable {
    /// ID, needed for SwiftUI to keep track of the items.
    var id: UUID = UUID()
    /// Name of the Group.
    var name : String
    /// Participants involved in the group.
    var participants : [Participant]
    //    var history: []
    
    // Also need a way to store the last created shuffle!
    init(name: String, participants: [String]) {
        self.name = name
        self.participants = [Participant]()
        for name in participants {
            self.participants.append(Participant(name:name))
        }
    }    
    
    var secretSanta : [SecretSantaItem] {
        get {
            return SecretSantaParticipants(group: self).shuffledItems
        }
    }
    
    var secretSantaParticipants : SecretSantaParticipants {
        get {
            return SecretSantaParticipants(group: self)
        }
    }
}

/// MARK: - 

extension SecretSantaParticipants {
    convenience init( group: Group ) {
        // Convert the participants into an array of String objects.
        var converted = [String]()
        for participant in group.participants {
            converted.append(participant.name)
        }
        
        // Now use the SecretSantaParticipants class to shuffle the array and generate a randomized list.
        self.init(participants: converted)
    }
}

