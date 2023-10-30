//
//  Player.swift
//  ScoreKeeper
//
//  Created by Andrew Higbee on 10/28/23.
//

import Foundation

struct Player: Codable, Equatable, Comparable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.score > rhs.score
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.score == rhs.score
    }
    
    var name: String
    var score: Int
    
    static let archiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("players").appendingPathExtension("plist")
    
    static func saveToFile(players: [Player]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(players)
        try? encodedEmojis?.write(to: Player.archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Player] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedPlayerData = try? Data(contentsOf: Player.archiveURL), let decodedPlayer = try? propertyListDecoder.decode(Array<Player>.self, from: retrievedPlayerData) {
            
            return decodedPlayer
        } else {
            return []
        }
    }

    static func samplePlayers() -> [Player] {
        return [Player(name: "Andrew", score: 0)]
    }
}
