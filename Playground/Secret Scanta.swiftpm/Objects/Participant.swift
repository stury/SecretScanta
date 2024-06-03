import SwiftUI

/// Participant object.
struct Participant : Hashable, Codable, Identifiable {
    /// ID to keep track of hte items correctly with Swiftui
    var id = UUID()
    /// Name of the participant
    let name : String
}
