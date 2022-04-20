//
//  GameViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    var name: String?
    var remainingTime = 60
    var timer = Timer()
    var previousBubbleClicked: UIColor!
    var currentScore: Double = 0
    var currentBubble = 0
    var maximumBubble = 15
    var bubbles = [Bubble]()
    var score = 0
    var highScore = 0
    var countdownTimer = Timer()
    var countdownTime = 3

    @IBOutlet var countdownLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        remainingTimeLabel.text = String(remainingTime)
        scoreLabel.text = String(Int(currentScore))
        countdownLabel.text = String(countdownTime)
        setHighScore()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { countdownTimer in
            self.countdown()
        }
    }
    
    @objc func countdown(){
        countdownTime -= 1
        countdownLabel.text = String(countdownTime)
        if countdownTime == 0 {
            countdownLabel.text = "Go"
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                    timer in
                    if self.countdownTime > -1 {
                        self.countdownTime -= 1
                    }
                    if self.countdownTime == -1 {
                        self.countdownLabel.isHidden = true
                        self.countdownTimer.invalidate()
                    }
                    self.deleteAllBubbles()
                    self.generateBubble()
                    self.counting()
            }
        }
    }
    // active timer, and generate bubble each second
    @objc func counting() {
        remainingTime -= 1
        remainingTimeLabel.text = String(remainingTime)

        if remainingTime == 0 {
            timer.invalidate()
            
            // show HighScore Screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
            vc.writeHighScore(name!, Int(currentScore))
        }
    }
    
    @objc func generateBubble() {
        let numberOfBubbles = Int.random(in: 5...maximumBubble)
        for _ in 1...numberOfBubbles {
            if currentBubble < maximumBubble{
                let bubble = Bubble()
                if !isIntersected(bubble) && isInTheGameView(bubble){
                    bubbles.append(bubble)
                    bubble.animation()
                    bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
                    self.view.addSubview(bubble)
                    currentBubble += 1
                }
            }
        }
    }
    
    func getGameViewXY() -> [CGFloat]{
        let frm = view.frame
        let bottom = frm.maxY - 150
        let right = frm.maxX - 50
        let top = remainingTimeLabel.frame.origin.y + 75
        let coordination = [top, bottom, right]
        return coordination
    }
    func isInTheGameView(_ bubble: Bubble) -> Bool {
        let gameViewCoordination = getGameViewXY()
        return bubble.frame.origin.x < gameViewCoordination[2] && bubble.frame.origin.y < gameViewCoordination[1] && bubble.frame.origin.y > gameViewCoordination[0]
    }
    
    func setHighScore() {
        let vc = HighScoreViewController()
        highScore = vc.getHighestScore()
        highScoreLabel.text = String(highScore)
    }
    func updatingHighScore(){
        if Int(currentScore) > highScore {
            highScoreLabel.text = String(Int(currentScore))
        }
    }
    
    func isIntersected(_ newBubble: Bubble) -> Bool {
        for bubble in bubbles {
            if newBubble.frame.intersects(bubble.frame){
                return true
            }
        }
        return false
    }
    
    func deleteAllBubbles() {
        for bubble in bubbles {
            bubble.removeFromSuperview()
        }
        bubbles.removeAll()
        currentBubble = 0
    }
    
    @IBAction func bubblePressed(_ sender: Bubble) {
//         remove pressed bubble from view
        currentScore = (sender.backgroundColor == previousBubbleClicked) ? currentScore + Double(sender.getScore()) * 1.5 : currentScore + Double(sender.getScore())
        scoreLabel.text = String(Int(currentScore))
        currentBubble -= 1
        previousBubbleClicked = sender.backgroundColor!
        if let index = bubbles.firstIndex(of: sender){
            bubbles.remove(at: index)
        }
        sender.removeFromSuperview()
        updatingHighScore()
    }
}
