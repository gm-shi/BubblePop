//
//  Bubble.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class Bubble: UIButton {
    
    let xPosition = Int.random(in: 25...400)
    let yPosition = Int.random(in: 25...800)
    var score = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectColorAndScore()
        self.frame = CGRect(x: xPosition, y: yPosition, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }

    func selectColorAndScore() {
        let randomNumber = Int.random(in: 0..<1000)
        switch(randomNumber){
            case 0..<400:
                self.backgroundColor = .red
                self.score = 1
            case 400..<700:
                self.backgroundColor = .purple
                self.score = 2
            case 700..<850:
                self.backgroundColor = .green
                self.score = 5
            case 850..<950:
                self.backgroundColor = .blue
                self.score = 8
            default:
                self.backgroundColor = .black
                self.score = 10
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
