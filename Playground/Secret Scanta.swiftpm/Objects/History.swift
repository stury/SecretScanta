//
//  History.swift
//  SecretScanta
//
//  Created by J. Scott Tury on 11/30/23.
//

import Foundation

struct History: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    /// Date this history was created.
    let date: Date
    /// Optional message about this history.
    let message: String
    /// Randomized list of SecretSantaItems...
    let items: [SecretSantaItem]
}
