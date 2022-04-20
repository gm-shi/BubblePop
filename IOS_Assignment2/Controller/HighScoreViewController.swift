//
//  HighScoreViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

struct GameScore: Codable {
    var name: String
    var score: Int
}

let KEY_HIGH_SCORE = "highScore"

class HighScoreViewController: UIViewController {
    
    
    @IBOutlet var HighScoreTableView: UITableView!
    
    var highScore:[GameScore] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        highScore.sort {$0.score > $1.score}
        
        self.highScore = readHighScore()
    }
    

    @IBAction func returnMainPage(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }

    func writeHighScore(_ newName: String, _ newScore: Int) {
        let defaults = UserDefaults.standard
        
        var updatedHighScoreFromGame: [GameScore] = readHighScore()
        
        updatedHighScoreFromGame.append(GameScore(name: newName, score: newScore))
        
        if updatedHighScoreFromGame.count > 3 {
            updatedHighScoreFromGame.sort {$0.score > $1.score}
            updatedHighScoreFromGame.removeLast()
        }
        
        defaults.set(try? PropertyListEncoder().encode(updatedHighScoreFromGame), forKey: KEY_HIGH_SCORE)
    }



    func readHighScore() -> [GameScore] {
        let defaults = UserDefaults.standard
        
        if let savedArrayData = defaults.value(forKey: KEY_HIGH_SCORE) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<GameScore>.self, from: savedArrayData){
                return array
            } else {
                return []
            }
        }else {
                return []
            }
    }
    
    func getHighestScore() -> Int {
        var score = readHighScore()
        if score.count < 1 {
            return 0;
        }
        else {
            score.sort {$0.score > $1.score}
            return score[0].score
        }
    }

}


extension HighScoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HighScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        let score = highScore[indexPath.row]
        cell.textLabel?.text = score.name
        cell.detailTextLabel?.text = "Score: \(score.score)"
        return cell
    }
    
}
