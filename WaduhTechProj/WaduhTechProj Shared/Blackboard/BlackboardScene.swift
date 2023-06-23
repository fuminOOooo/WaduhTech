//
//  BlackboardScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class BlackboardScene: SKScene {
    
    var spriteNode : SKSpriteNode!
    var timerBlackboard: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var timeRemaining = 15
    
    let views: [SKTexture] = [SKTexture(imageNamed: "blackboard"), SKTexture(imageNamed: "blackboard1"), SKTexture(imageNamed: "blackboard2"), SKTexture(imageNamed: "blackboard3"), SKTexture(imageNamed: "blackboard4")]
    
    var currentTextureIndex: Int = 0 {
            didSet {
                updateSpriteTexture()
            }
        }
    
    func startCountdown() {
        counter = timeRemaining // Set counter to countdownStart
        countdownTimer.invalidate() // Invalidate the previous timer if it exists
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func decrementCounter() {
        counter -= 1
        timerBlackboard.text = "\(counter)"
        updateTextureIndex()
        
        if counter < 1 {
            countdownTimer.invalidate()
        }
    }

    func updateTextureIndex() {
            
            if counter <= 3 {
                currentTextureIndex = 4
            } else if counter <= 6 {
                currentTextureIndex = 3
            } else if counter <= 9 {
                currentTextureIndex = 2
            } else if counter <= 12 {
                currentTextureIndex = 1
            } else if counter <= 15 {
                currentTextureIndex = 0
            }

        }
    
    func updateSpriteTexture() {
            let textureAction = SKAction.setTexture(views[currentTextureIndex])
            textureAction.speed = 0.5
            spriteNode.run(textureAction)
        }
    
}
