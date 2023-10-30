//
//  PlayerController.swift
//  ScoreKeeper
//
//  Created by Andrew Higbee on 10/30/23.
//

import Foundation

class PlayerController {
    static let shared = PlayerController()
    
    var players: [Player] = []

    func loadInitialPlayers() {
        if Player.loadFromFile().isEmpty {
            players = Player.samplePlayers()
        } else {
            players = Player.loadFromFile()
        }
    }
    
    func addPlayer(_ player: Player) {
        players.append(player)
        players.sort()
        Player.saveToFile(players: players)
    }
    
    func update(_ player: Player, index: Int) {
        players[index] = player
        players.sort()
        Player.saveToFile(players: players)
    }
    
    func remove(at index: Int) {
        players.remove(at: index)
        Player.saveToFile(players: players)
    }
    
}
