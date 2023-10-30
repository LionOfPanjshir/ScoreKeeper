//
//  ScoresTableViewCell.swift
//  ScoreKeeper
//
//  Created by Andrew Higbee on 10/28/23.
//

import UIKit

protocol PlayerScoreDelegate {
    func scoreWasChanged(for player: Player, newScore: Int)
}

class ScoresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    
    var player: Player?
        
    var playerScoreDelegate: PlayerScoreDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func update(with player: Player) {
        self.player = player
        playerNameLabel.text = player.name
        playerScoreLabel.text = String(player.score)
        scoreStepper.value = Double(player.score)
    }
    
    func updateScoreLabel() {
        playerScoreLabel.text = "\(Int(scoreStepper.value))"
    }
    
    @IBAction func scoreStepperTapped(_ sender: Any) {
        updateScoreLabel()
        guard let player else { return }
        playerScoreDelegate?.scoreWasChanged(for: player, newScore: Int(scoreStepper.value))
        
    }
}
