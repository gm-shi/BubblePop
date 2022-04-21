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
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbleNumberLabel.text = String(Int(bubbleNumberSlider.value))
        timeSliderLabel.text = String(Int(timeSlider.value))
    }
    
    @IBAction func handleTimeSliderChange(_ sender: UISlider) {
        timeSliderLabel.text = String(Int(timeSlider.value))
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
