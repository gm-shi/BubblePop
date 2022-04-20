//
//  BlueViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
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
        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func handleTimeSliderChange(_ sender: UISlider) {
        timeSliderLabel.text = String(Int(timeSlider.value))
    }
    
    @IBAction func handleBubbleNumberSliderChange(_ sender: UISlider) {
        bubbleNumberLabel.text = String(Int(bubbleNumberSlider.value))

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            VC.name = nameTextField.text!
            VC.remainingTime = Int(timeSlider.value)
            VC.maximumBubble = Int(bubbleNumberSlider.value)
        }
    }
  
}
