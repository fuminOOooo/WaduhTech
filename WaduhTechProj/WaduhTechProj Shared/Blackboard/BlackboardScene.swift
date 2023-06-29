//
//  BlackboardScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class BlackboardScene {
    
    var spriteNode : SKSpriteNode!
    var timerBlackboard: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var timeRemaining = 30
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false

    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
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
        counter = max(counter, 0)
        timerBlackboard.text = "\(counter)"
        updateTextureIndex()
        updateAudioIndex()
    }
    
    func updateTextureIndex() {
            
            if counter <= 6 {
                currentTextureIndex = 4
            } else if counter <= 12 {
                currentTextureIndex = 3
            } else if counter <= 18 {
                currentTextureIndex = 2
            } else if counter <= 24 {
                currentTextureIndex = 1
            } else if counter <= 30 {
                currentTextureIndex = 0
            }
        }
    
    func enableSoundEffects() {
        soundEnabled = true
    }
    
    func disableSoundEffects() {
        soundEnabled = false
    }
    
    func updateAudioIndex() {
        if soundEnabled {
            
            if counter == 7 {
                let blackboardSoundL = SKAction.playSoundFileNamed("blackboard_L", waitForCompletion: false)
                scene.run(blackboardSoundL)
            } else if counter == 14 {
                let blackboardSoundI = SKAction.playSoundFileNamed("blackboard_I", waitForCompletion: false)
                scene.run(blackboardSoundI)
            } else if counter == 21 {
                let blackboardSoundA = SKAction.playSoundFileNamed("blackboard_A", waitForCompletion: false)
                scene.run(blackboardSoundA)
            } else if counter == 28 {
                let blackboardSoundF = SKAction.playSoundFileNamed("blackboard_F", waitForCompletion: false)
                scene.run(blackboardSoundF)
            }
        }
    }
    
    func updateSpriteTexture() {
            let textureAction = SKAction.setTexture(views[currentTextureIndex])
            textureAction.speed = 0.5
            spriteNode.run(textureAction)
        }
    
}
