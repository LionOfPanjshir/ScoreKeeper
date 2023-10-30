//
//  ScoresTableViewController.swift
//  ScoreKeeper
//
//  Created by Andrew Higbee on 10/27/23.
//

import UIKit

class ScoresTableViewController: UITableViewController {
    
    let controller = PlayerController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.loadInitialPlayers()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoresCell", for: indexPath) as! ScoresTableViewCell
        
        var player = controller.players[indexPath.row]
        cell.scoreStepper.value = Double(player.score)
        cell.playerScoreDelegate = self
        cell.update(with: player)
        return cell
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func tableView(_ tablewView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    @IBAction func unwindToScoresTablesView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? AddPlayerTableViewController, let player = sourceViewController.player else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            controller.update(player, index: selectedIndexPath.row)
        } else {
            controller.addPlayer(player)
        }
        tableView.reloadData()
    }
    
    @IBSegueAction func addEditPlayer(_ coder: NSCoder, sender: Any?) -> AddPlayerTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let playerToEdit = controller.players[indexPath.row]
            return AddPlayerTableViewController(coder: coder, player: playerToEdit)
        } else {
            return AddPlayerTableViewController(coder: coder, player: nil)
        }
    }
}

extension ScoresTableViewController: PlayerScoreDelegate {
    
    func scoreWasChanged(for player: Player, newScore: Int) {
        guard let index = controller.players.firstIndex(of: player) else { return }
        var updatedPlayer = player
        updatedPlayer.score = newScore
        controller.update(updatedPlayer, index: index)
        tableView.reloadData()
    }

}
