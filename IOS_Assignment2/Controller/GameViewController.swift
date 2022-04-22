//
//  GameViewController.swift
//  IOS_Assignment2
//
//  Created by Gongming Shi on 18/04/2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var countdownLabel: UILabel!
    var soundPlayer: AVAudioPlayer?
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

    override func viewDidLoad() {
        super.viewDidLoad()

        remainingTimeLabel.text = String(remainingTime)
        scoreLabel.text = String(Int(currentScore))
        countdownLabel.text = String(countdownTime)
        setHighScore()
        bubbleSoundEffect()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { countdownTimer in
            self.countdown()
        }
    }
    // 3, 2, 1 coundown timer
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
                    self.deleteRandomNumberOfBubbles()
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
            // pass the data to high score controller
            vc.writeHighScore(name!, Int(currentScore))
        }
    }
    // generate bubbles with a random number
    @objc func generateBubble() {
        let numberOfBubbles = Int.random(in: 1...maximumBubble)
        for _ in 1...numberOfBubbles {
            if currentBubble < maximumBubble{
                let bubble = Bubble()
                createBubbleView(bubble)
                // check if the bubble intersect with other bubbles
                if !isIntersected(bubble) {
                    bubbles.append(bubble)
                    bubble.animation()
                    bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
                    // add bubble to the view
                    self.view.addSubview(bubble)
                    currentBubble += 1
                }
            }
        }
    }
    // create bubble view with CGRect
    func createBubbleView(_ bubble: Bubble) {
        let frm = view.frame
        let yPosition = Int.random(in: Int(remainingTimeLabel.frame.origin.y) + 75...Int(frm.maxY) - 150)
        let xPosition = Int.random(in: 25...Int(frm.maxX) - 75)
        bubble.frame = CGRect(x: xPosition, y: yPosition, width: 50, height: 50)
        bubble.layer.cornerRadius = 0.5 * bubble.bounds.size.width
    }
    // get the greatest score in the database and set the lable to be that
    func setHighScore() {
        let vc = HighScoreViewController()
        highScore = vc.getHighestScore()
        highScoreLabel.text = String(highScore)
    }
    // if current score is greater than highScore then update the highScore
    func updatingHighScore(){
        if Int(currentScore) > highScore {
            highScoreLabel.text = String(Int(currentScore))
        }
    }
    // check if two bubbles intersects with each other
    func isIntersected(_ newBubble: Bubble) -> Bool {
        for bubble in bubbles {
            if newBubble.frame.intersects(bubble.frame){
                return true
            }
        }
        return false
    }
    // remove a random number of bubble in the view
    func deleteRandomNumberOfBubbles() {
        var randomNumber = Int.random(in: 0...currentBubble)
        for bubble in bubbles {
            if randomNumber >= 0{
                bubble.flash()
                bubble.removeFromSuperview()
                randomNumber -= 1
                if let index = bubbles.firstIndex(of: bubble){
                    bubbles.remove(at: index)
                }
                currentBubble -= 1
            }
        }
    }
    // handle bubble pressed
    @IBAction func bubblePressed(_ sender: Bubble) {
        //play sound effect
        soundPlayer?.play()
        //if the bubble pressed is same color with previous bubble pressed, then score * 1.5
        currentScore = (sender.backgroundColor == previousBubbleClicked) ? currentScore + Double(sender.getScore()) * 1.5 : currentScore + Double(sender.getScore())
        scoreLabel.text = String(Int(currentScore))
        currentBubble -= 1
        previousBubbleClicked = sender.backgroundColor!
        //remove this bubble from the current bubble array
        if let index = bubbles.firstIndex(of: sender){
            bubbles.remove(at: index)
        }
        // remove pressed bubble from view
        sender.flash()
        sender.removeFromSuperview()
        // check if current score geater than high score
        updatingHighScore()
    }
    // make sound player to load the sound effect,
    // this would having terminal error message, but this should only happends when using simulator not the actual device
    func bubbleSoundEffect(){
        let soundPath = Bundle.main.path(forResource: "pop", ofType: "mp3")!
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            soundPlayer?.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
}
