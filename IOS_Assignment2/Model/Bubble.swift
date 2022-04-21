//
//  Bubble.swift
//  IOS_Assignment2
//
//  Created by Gongming Shi on 18/04/2022.
//

import UIKit

class Bubble: UIButton {
    
    let xPosition = Int.random(in: 25...400)
    let yPosition = Int.random(in: 25...800)
    var score = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectColorAndScore()

    }
//assign the color and socre based on probabilities
    func selectColorAndScore() {
        let randomNumber = Int.random(in: 0..<1000)
        switch(randomNumber){
        case 0..<400:
            self.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.1295394519, blue: 0.1346460857, alpha: 1)
            self.score = 1
        case 400..<700:
            self.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            self.score = 2
        case 700..<850:
            self.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.score = 5
        case 850..<950:
            self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            self.score = 8
        case 950..<999:
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.score = 10
        default:
            print("error")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getScore() -> Int {
        return self.score
    }
   
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
}
