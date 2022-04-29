//
//  SettingViewController.swift
//  IOS_Assignment2
//
//  Created by Gongming Shi on 18/04/2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet var bubbleNumberLabel: UILabel!
    @IBOutlet var timeSliderLabel: UILabel!
    @IBOutlet var bubbleNumberSlider: UISlider!
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var notification: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbleNumberLabel.text = String(Int(bubbleNumberSlider.value))
        timeSliderLabel.text = String(Int(timeSlider.value))
        startGameButton.isEnabled = false
        startGameButton.alpha = 0.5
        startGameButton.layer.cornerRadius = 5
        notification.text = "Please put you name before start"
    }
    
    @IBAction func handleTimeSliderChange(_ sender: UISlider) {
        timeSliderLabel.text = String(Int(timeSlider.value))
    }
    // if the the name is none disable the start game button
    @IBAction func handleNoneInput(_ sender: Any) {
        if nameTextField.text == "" {
            startGameButton.isEnabled = false
            startGameButton.alpha = 0.5
            notification.text = "Please put you name before start"
        }
        else{
            startGameButton.isEnabled = true
            startGameButton.alpha = 1
            notification.text = ""
        }
    }
    @IBAction func handleBubbleNumberSliderChange(_ sender: UISlider) {
        bubbleNumberLabel.text = String(Int(bubbleNumberSlider.value))

    }
    //pass parameters to game view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            VC.name = nameTextField.text!
            VC.remainingTime = Int(timeSlider.value)
            VC.maximumBubble = Int(bubbleNumberSlider.value)
        }
    }
  
}
