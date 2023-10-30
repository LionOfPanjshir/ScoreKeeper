//
//  AddPlayerTableViewController.swift
//  ScoreKeeper
//
//  Created by Andrew Higbee on 10/27/23.
//

import UIKit

class AddPlayerTableViewController: UITableViewController {
    
    var player: Player?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    
    required init?(coder: NSCoder, player: Player?) {
        super.init(coder: coder)
        self.player = player
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let player = player {
            nameTextField.text = player.name
            scoreTextField.text = String(player.score)
            title = "Edit Player"
        } else {
            title = "Add Player"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let name = nameTextField.text ?? ""
        let score = Int(scoreTextField.text ?? "")
        
        player = Player(name: name, score: score ?? 0)
    }
}
